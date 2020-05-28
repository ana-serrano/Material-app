#PCA space functions from:
#On Optimal, Minimal BRDF Sampling for Reflectance Acquisition 
#Nielsen, J. B.; Jensen, H. W.; Ramamoorthi R.
#http://brdf.compute.dtu.dk/

import numpy as np
import scipy as sp
import scipy.io as sio
import time
import sys

def readMERLBRDF(filename):
    """Reads a MERL-type .binary file, containing a densely sampled BRDF
    
    Returns a 4-dimensional array (phi_d, theta_d, theta_h, channel)"""
    print "Loading MERL-BRDF: ",filename
    try: 
        f = open(filename, "rb")
        dims = np.fromfile(f,int,3)
        vals = np.fromfile(f,np.float64,-1)
        f.close()
    except IOError:
        print "Cannot read file:", path.basename(filename)
        return
        
    BRDFVals = np.swapaxes(np.reshape(vals,(dims[2], dims[1], dims[0], 3),'F'),1,2)
    BRDFVals *= (1.00/1500,1.15/1500,1.66/1500) #Colorscaling
    BRDFVals[BRDFVals<0] = -1
    
    return BRDFVals
    
def saveMERLBRDF(filename,BRDFVals,shape=(180,90,90),toneMap=True):
    "Saves a BRDF to a MERL-type .binary file"
    print "Saving MERL-BRDF: ",filename
    BRDFVals = np.array(BRDFVals)   #Make a copy
    if(BRDFVals.shape != (np.prod(shape),3) and BRDFVals.shape != shape+(3,)):
        print "Shape of BRDFVals incorrect"
        return
        
    #Do MERL tonemapping if needed
    if(toneMap):
        BRDFVals /= (1.00/1500,1.15/1500,1.66/1500) #Colorscaling
    
    #Are the values not mapped in a cube?
    if(BRDFVals.shape[1] == 3):
        BRDFVals = np.reshape(BRDFVals,shape+(3,))
        
    #Vectorize:
    vec = np.reshape(np.swapaxes(BRDFVals,1,2),(-1),'F')
    shape = [shape[2],shape[1],shape[0]]
    
    try: 
        f = open(filename, "wb")
        np.array(shape).astype(int).tofile(f)
        vec.astype(np.float64).tofile(f)
        f.close()
    except IOError:
        print "Cannot write to file:", path.basename(filename)
        return
        
def MapBRDF(brdfData,maskMap,median):
	pTotal = np.shape(maskMap)[0]
	brdfData = np.reshape(brdfData,(pTotal,-1)) #Reshape to always 2-dim
	brdfValid = brdfData[maskMap,:]
	return np.log((brdfValid+0.001)/(median+0.001)) #Our mapping
#	 return np.log(brdfValid)	 #Only log mapping
#	 return brdfValid #Raw values

def UnmapBRDF(mappedData,maskMap,median):
	pTotal = np.shape(maskMap)[0]
	mappedData = np.reshape(mappedData,(np.shape(median)[0],-1)) #Reshape to always 2-dim
	n = np.shape(mappedData)[1]
	unmapped = np.ones((pTotal,n))*-1
	unmapped[maskMap,:] = np.exp(mappedData)*(median+0.001)-0.001 #Our mapping
#	 unmapped[maskMap,:] = np.exp(mappedData) #Only log mapping
#	 unmapped[maskMap,:] = mappedData #Raw values
	return unmapped
	
def ProjectToPCSpace(data,PCs,relativeOffset, eta=0):
	nPCs = np.clip(np.shape(data)[0],1,np.shape(PCs)[1])	#Number of PCs to use (if only 5 values are known, only the first 5 PCs are used)
	b = data-relativeOffset
	A = PCs[:,0:nPCs]

	U, s, Vt = sp.linalg.svd(A, full_matrices=False, check_finite=False) #Use scipy instead of numpy for SVD
	Ut = np.transpose(U)
	V = np.transpose(Vt)
	Sinv = np.diag(s/(s*s+eta))
	x = V.dot(Sinv).dot(Ut).dot(b)	 
	return x