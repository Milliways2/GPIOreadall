from numpy import linspace, reshape
from matplotlib import pyplot
from multiprocessing import Pool

xmin, xmax = -2.0 ,0.5    # x range
ymin, ymax = -1.25,1.25   # y range
nx  , ny   =  1000,1000   # resolution
maxiter    =  50          # max iterations

def mandelbrot(z): # computation for one pixel
  c = z
  for n in range(maxiter):
    if abs(z)>2: return n   # divergence test
    z = z*z + c
  return maxiter

X = linspace(xmin,xmax,nx) # lists of x and y
Y = linspace(ymin,ymax,ny) # pixel co-ordinates

# main loops
N = []

# for y in Y:
#   for x in X:
#     z  = complex(x,y)
#     N += [mandelbrot(z)]
p = Pool()
Z = [complex(x,y) for y in Y for x in X]
# N = map(mandelbrot,Z)
N = p.map(mandelbrot,Z)

N = reshape(N, (nx,ny)) # change to rectangular array

pyplot.imshow(N) # plot the image
pyplot.show()
