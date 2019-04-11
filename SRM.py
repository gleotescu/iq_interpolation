# initialize data 
###
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

# plot table
import texttable as tt

def plotTable(headers,
              rows,
              valign=True,
              column_width=False,
              no_deco=False,
              precision=1):
    tab = tt.Texttable()
    if len(headers) > 0:
        tab.header(headers)
    tab.set_precision(precision)
    for row in rows:
        tab.add_row(row)

    if valign and len(headers) > 0:
        tab.set_cols_valign(['m'] * len(headers))

    if column_width:
        columns = [0] * len(rows[0])
        for row in rows:
            for i, cell in enumerate(row):
                if isinstance(row[i], str):
                    columns[i] = max(
                        columns[i],
                        max([len(line) for line in row[i].split('\n')]))
        for i, head in enumerate(headers):
            columns[i] = max(columns[i], len(head))
        tab.set_cols_width(columns)

    if no_deco:
        tab.set_deco(tt.Texttable.HEADER | tt.Texttable.VLINES)

    s = tab.draw()
    return s

def data_from_file(file_name):
    data = np.loadtxt(file_name, delimiter =',')
    alfa = list(range(0,31))
    flux = data[0:, :]
    I_currents = [0.2,0.4,0.6,0.8,1.0,1.2,1.,1.6,1.8,2.0,2.2,2.4,2.6]
    x_Label = " I [A]"
    y_Label = "Flux"
    return alfa, flux, I_currents, x_Label, y_Label
    
alfa, flux, I_currents, xLabel, yLabel = data_from_file('SRM/SRM.txt')

#

from subprocess import call
plt.clf()
plt.rcParams["figure.figsize"] = [64, 64]
plt.rcParams['xtick.labelsize']=14
plt.rcParams['ytick.labelsize']=14


for idx in alfa:
    df = flux[:, idx]    
    plt.plot(I_currents, df, label='alfa = %d grades' %(idx))
    plt.ylim([0, 0.4])
    plt.xlim([0, 3])
    plt.xticks(I_currents)
    plt.xlabel(xLabel, fontsize = 16)
    plt.ylabel(yLabel, fontsize = 16)
    plt.legend(loc='best', fontsize = 16)
plt.grid()
plt.savefig('SRM_Original_curves.png', dpi = 300)
plt.show()
