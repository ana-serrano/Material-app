import numpy as np
from fractions import Fraction	
from pca_functions import *

	
def rgb2lab(r):
	xyz = np.dot(rgb2xyz,r)
	
	X = xyz[0,:] / 0.950456
	Y = xyz[1,:]
	Z = xyz[2,:] / 1.088754
	T = 0.008856	
	
	idx = [i for i,v in enumerate(X) if v > T]
	fX = ((903.3/116.0)*X + 16.0/116.0)	
	fX[idx] = np.sign(X[idx])*pow((X[idx]),Fraction('1/3'))
	
	idx = [i for i,v in enumerate(Y) if v > T]	
	fY = ((903.3/116.0)*Y + 16.0/116.0)
	fY[idx] = np.sign(Y[idx])*pow((Y[idx]),Fraction('1/3'))	
	
	
	idx = [i for i,v in enumerate(Z) if v > T]	
	fZ =((903.3/116.0)*Z + 16.0/116.0)
	fZ[idx] = np.sign(Z[idx])*pow((Z[idx]),Fraction('1/3'))
	
	L = 116.0*fY - 16.0
	a = 500.0*(fX - fY)
	b = 200.0*(fY - fZ)
	
	return(L,a,b)


def lab2rgb(L,a,b):	
	T1 = 0.008856
	T2 = 6.0/29.0
		
	fY = (L + 16.0)/116.0
	fX = np.asarray([m/500.0 + n for m,n in zip(a,fY)],dtype=np.float32)
	fZ = np.asarray([m - n/200.0 for m,n in zip(fY,b)],dtype=np.float32)
	
	Y = pow(fY,3.0)
	idx = [i for i,v in enumerate(fY) if v <= T2]
	Y[idx] = 3.0 * pow((6.0/29.0),2) * (fY[idx] - 4.0/29.0) 
	
	X = pow(fX,3.0)
	idx = [i for i,v in enumerate(fX) if v <= T2]
	X[idx] = 3.0 * pow((6.0/29.0),2) * (fX[idx] - 4.0/29.0) 
	
	Z = pow(fZ,3.0)
	idx = [i for i,v in enumerate(fZ) if v <= T2]
	Z[idx] = 3.0 * pow((6.0/29.0),2) * (fZ[idx] - 4.0/29.0) 
	
	Y = Y
	X = X * 0.950456
	Z = Z * 1.088754
	
	mtx = np.stack((X, Y, Z), axis=0) 
	rgb=np.dot(xyz2rgb,mtx)
	return(rgb)

rgb2xyz =     np.array([[0.412453, 0.357580, 0.180423],
						[0.212671, 0.715160, 0.072169],
						[0.019334, 0.119193, 0.950227]])
xyz2rgb =     np.array([[ 3.240479, -1.537150, -0.498535],
						[-0.969256,	 1.875992,	0.041556],
						[ 0.055648, -0.204043,  1.057311]])
	
def main():
	dataDir = "precompData"
	##############################################################################################################
	#LOAD PRECOMPUTED DATA
	##############################################################################################################
	maskMap = np.load('%s/MaskMap.npy'%dataDir)	  #Indicating valid regions in MERL BRDFs
	median = np.load('%s/Median.npy'%dataDir)	  #Median, learned from trainingdata
	cosMap = np.load('%s/CosineMap.npy'%dataDir)  #Precomputed cosine-term for all BRDF locations (ids)
	relativeOffset = np.load('%s/RelativeOffset.npy'%dataDir) #Offset, learned from trainingdata
	Q = np.load('%s/ScaledEigenvectors.npy'%dataDir) #Scaled eigenvectors, learned from trainingdata

	pth = sys.argv[1]
	
	nPCs = 5
	dictionary = sio.loadmat('%s'%(pth),squeeze_me=True)
	L = np.array(dictionary['pcL']) 
	a = np.array(dictionary['pca']) 
	b = np.array(dictionary['pcb']) 
	#Use this new edited L together with the original brdf a and b
	rgb = lab2rgb(L,a,b)
	recon_edit = np.dot(Q[:,0:nPCs],rgb.T)+relativeOffset
	if(cosMap is None):
		unmapped_edit = UnmapBRDF(recon_edit, maskMap, median)
	else:
		unmapped_edit = UnmapBRDF(recon_edit, maskMap, median)
		unmapped_edit[maskMap] /= cosMap
	
	unmapped_edit[unmapped_edit<0] = 0
	saveMERLBRDF('%s.binary'%(pth[:-4]),unmapped_edit)
	
	return


if __name__ == "__main__":
	main()
		
		
		
