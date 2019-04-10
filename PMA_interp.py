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

def data_from_file(file_name,case):
    #case = 1-> Id from file. Iq in 0->220 > 'i_direct_flux'
    #case = 2 -> Iq from file. Id in 0->220 > 'j_q_flux'
    data = np.loadtxt(file_name, delimiter=',')
    ids = data[0, :]    
    dfs = data[1:, :]
    iqs = list(range(180, -1, -10))
    if case == 1:
        xLabel = 'd-axis current - Id [A]'
        yLabel = 'Direct flux linkage [Wb]'
        Is = 'Iq '
    elif case == 2:
        xLabel = 'q-axis current -Iq [A]'
        yLabel = 'Quadratic flux [Wb]'  
        Is = 'Id'
    return ids, dfs, iqs, xLabel, yLabel, Is
ids, dfs, iqs, Is, xLabel, yLabel = data_from_file('PMASynRM_from_Madalina/D_d_madalina.txt',1)

#cubic spline interpolation
from scipy.interpolate import interp1d
from scipy import interpolate
import itertools
import sys
from pandas import DataFrame as df

def sum_squared_error(gr, pred):
    gr = np.array(gr)
    pred = np.array(pred)
    return (10 ** 6) * (1 / gr.shape[0]) * sum((gr - pred) ** 2)

curve_indices = list(range(0, 12)) 
curves_for_plot = [1]# list(range(1, 13,2))
pts_for_plot = [5,4,3]

# try interpolating with only 10, 9, 8 ... 4, 3 points
sub_points_num  = list(range(len(ids)-1, 2, -1))

headers = ['%s' %Is] + ['pts num: %d' % pts for pts in sub_points_num] + ['    Best 5 Points   ']
rows = []
x_best_5_pts = []
y_best_5_pts = []

#define total error per no of points
total_error_per_points_num = np.zeros(shape = 19)

#dataframe for error table latex
error_latex = np.zeros(shape = (19,19))

for curve in curve_indices: #pentru fiecare curba Iq
    y = dfs[:, curve] #iau fluxurile corespunzatoare
    x = ids #iau id-urile
         
    tck = interpolate.splrep(x, y, s=0) #face spline pe toate cele 12 puncte
    x_new = np.linspace(min(x), max(x), 200)
        
    # baseline = y values obtained when interpolating with all ground truth points
    baseline = interpolate.splev(x_new, tck, der=0)
    
    row = ['%s %d' % (Is, iqs[curve])]
    best_5_points =[]
   
    for points_num in sub_points_num:
        # store best configuration
        best_pts     = (x, y)
        best_interp  = (x_new, baseline)
        best_error   = sys.float_info.max
        best_err_gr  = sys.float_info.max
    
        sub_points_sets = itertools.combinations(range(len(ids)), points_num)
        for pts in sub_points_sets:
            pts = list(pts)
            x_     = x[pts]
            y_     = y[pts]
          
            if points_num == 3:
                tck_   = interpolate.splrep(x_, y_, s=0, k=2)
                y_new_ = interpolate.splev(x_new, tck_, der=0) 
            else:
                tck_   = interpolate.splrep(x_, y_, s=0)
                y_new_ = interpolate.splev(x_new, tck_) 
        
            # error -- difference between baseline interp curve and current one
            error = sum_squared_error(baseline, y_new_)
            
            if error < best_error:
                best_error  = error
                best_pts    = (x_, y_) # best points from combination
                best_interp = (x_new, y_new_) # best points from interpolation
                
                # interpolate in target points + evaluate error
                gr_interp = interpolate.splev(x, tck_, der=0)
                best_err_gr = sum_squared_error(y, gr_interp)
        print(curve)
        print(best_err_gr)

        if points_num == 5:
            best_5_points = best_pts[0]
            x_best_5_pts.append(best_pts[0])#to be used for linear interp
            y_best_5_pts.append(best_pts[1])#to be used for linear interp
            
        row.append(best_err_gr)
        error_latex[curve][points_num] = best_err_gr
        
        total_error_per_points_num[points_num] += best_err_gr
        
      
#         if curve in curves_for_plot and points_num in pts_for_plot:
#             plt.clf()
#             plt.rcParams["figure.figsize"] = [12, 8]
#             plt.rcParams['xtick.labelsize']=14
#             plt.rcParams['ytick.labelsize']=14
#             plt.scatter(x, y, label='Original 12 points for Iq = %d A'%iqs[curve])
#             plt.plot(x_new, baseline, label='Original spline for 12 pts')
#             plt.scatter(best_pts[0], best_pts[1], label='Best 5 pts')
#             plt.plot(best_interp[0], best_interp[1], label='Best interpolation')

#             plt.ylim([0, 0.25])
#             plt.xlim([0, 220])
#             plt.xticks(ids)
#             plt.xlabel(xLabel, fontsize = 14)
#             plt.ylabel(yLabel, fontsize = 14)
           

#             plt.legend(loc='best', fontsize = 14)
#             plt.title('%s = %d A , No of Id values = %d' % (Is,iqs[curve], points_num),fontsize=18)
#             plt.grid()
#             plt.savefig('Points_num{}for Iq={}.png'.format(points_num, iqs[curve]))
#             plt.show()
    
    row.append(best_5_points)
    rows.append(row)

#tabel csv for best_5_points
#df_best_5_points = df(data = x_best_5_pts,index = iqs, columns = list(range(1,6)))                                  
                     
# print(df_best_5_points)
#df_best_5_points.to_csv('PMA_best_5_points.csv')

#error_latex = np.around(error_latex, decimals=2)  

#df_error_latex = df(data = error_latex[:,3:8], index = iqs, columns = list(range(3,8)))

#df_error_latex.to_csv('PMA_interp_error_points.csv')
    
    
#plotting the errors
    
# x_axis = list(range(3,12))
# plt.clf()
# plt.rcParams["figure.figsize"] = [12, 8]
# plt.rcParams['xtick.labelsize']=14
# plt.rcParams['ytick.labelsize']=14

# # plt.title('Spline interpolation error for different number of points',fontsize=18)
# plt.scatter(x_axis,total_error_per_points_num[3:12]/12)
# plt.plot(x_axis,total_error_per_points_num[3:12]/12)
# plt.xlabel('No of points',fontsize=18)
# plt.ylabel('Spline interpolation error',fontsize=18)
# # plt.ylim([0,2])
# plt.grid()
# plt.savefig('interp_error_Points_graphic.png', dpi = 200)
# plt.show()

print('Interpolation error ( sum squared error * 10 ^ 6)')
table = plotTable(headers=headers, rows=rows, column_width=True, precision=5)
print(table)
