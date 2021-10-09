from os.path import basename
import matplotlib.pyplot as plt
import numpy as np
from numpy import sin, cos, pi, arcsin, arccos, sqrt
from matplotlib import rc

def pdf_empirical_evaluation(x, nbins):
    if not nbins:
        nbins = 1000

    h, bins_centers, patches = plt.hist(x, nbins)
    bin_width = bins_centers[1:] - bins_centers[:len(bins_centers) - 1]
    bin_width = np.mean(bin_width)
    epdf = (h/len(x))/bin_width

    return epdf, bins_centers

if __name__ == "__main__":
    # I hate small fonts!
    rc('font', **{'size': 18})
    rc('font', **{'family':'serif', 'serif':['Arial']})
    rc('text', usetex=True) # requires LaTeX!!!
    plt.close('all')
    plt.ion() # interactive

    trials = int(1e7)
    var = 1
    m = 0
    x = np.random.uniform(low=0., high=1., size=trials)
    x = x**(1/4) # the inverse of f_X = 4x^3 (0 <= x < 1)

    y = sin(pi*x)
    ty = lambda y: (4/(pi*sqrt(1-y**2))) * (arcsin(y)/(pi**3) + ((pi-arcsin(y))/pi)**3)

    epdf, bins_centers = pdf_empirical_evaluation(y, nbins=1000)

    plt.clf()
    plt.plot(bins_centers[:len(epdf)], epdf, label='Empirical', linewidth=2)
    plt.plot(bins_centers[:len(epdf)], ty(bins_centers[:len(epdf)]), label='Theoretical', linewidth=2)
    plt.xlabel('$x$')
    plt.ylabel('$f_Y$')
    plt.minorticks_on()
    plt.grid(which='major',)
    plt.grid(which='minor', alpha=0.3)
    plt.legend()
    plt.show()

    img_fname = basename(__file__).replace('py', 'png')
    plt.savefig(img_fname, dpi=300, bbox_inches='tight')
