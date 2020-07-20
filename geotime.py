from tkinter import *
import csv

root = Tk()
root.title("GeoTime Look Up")
root.geometry("1000x800")

# data==============


# menu==========================

menu = Menu(root)
root.config(menu=menu)
root.columnconfigure(0, weight=1)

fileMenu = Menu(menu)
menu.add_cascade(label="Function", menu=fileMenu)

editMenu = Menu(menu)
menu.add_cascade(label="About", menu=editMenu)

# about ====================


def aboutData():
    about_data_text1 = "The geologic time scale data, including interval names, maximum and minimum ages, "
    about_data_text2 =  "and standard colors in the international chart, are pulled from the Macrostrat database. "
    about_data_text3 = "The data in Macrostrat is based on the latest International Commission on Stratigraphy."
    about_label_d1 = Label(frame_about, text="  ").pack()
    about_label= Label(frame_about, text=about_data_text1).pack()
    about_label2 = Label(frame_about, text=about_data_text2).pack()
    about_label3 = Label(frame_about, text=about_data_text3).pack()

def aboutAuthor():
    about_author_text1 = "This tool is developped by Shan Ye, "
    about_author_text2 = "a PhD student in geoscience at University of Wisconsin-Madison."
    about_label_a1 = Label(frame_about, text="  ").pack()
    about_label4 = Label(frame_about, text=about_author_text1).pack()
    about_label5 = Label(frame_about, text=about_author_text2).pack()



# frames ==============================

frame = LabelFrame(root, text = "Data Input", width=685)
frame.pack(side = 'left', fill='both', expand=True, padx=10, pady=10)

frame_res = LabelFrame(root, text = "Results", width = 685)
frame_res.pack( fill='both', expand=True, padx=10, pady=10)

frame_about = LabelFrame(root, text = "About", width = 685, bd = 0)
frame_about.pack()

frame_calc = LabelFrame(frame, text = "", bd = 0)
frame_calc.grid(row = 14, column = 0)

frame_pt = LabelFrame(frame, text = "", bd = 0)
frame_pt.grid(row = 12, column = 0)

# Starting texts ================

label1 = Label(frame, text = "Enter the Ma. (e.g. 1500 for 1500 Ma):").grid(row = 0, column = 0)

# input box ===================

e = Entry(frame, width = 20, bg = "gray80", fg = "black", borderwidth = 5)
e.grid(row = 1, column = 0, columnspan = 2)

# get options ====================

label1 = Label(frame, text = "Display options:").grid(row = 2, column = 0)

# dropdown menu for periods =================
options = [
    "Period",
    "Epoch",
    "Age",
    "Show All"
]

def get_option_level():
    global time_level
    time_level = time_opt.get()

time_opt = StringVar()
time_opt.set(options[0])

drop = OptionMenu(frame, time_opt, *options)
drop.grid(row = 3, column = 0)

label3 = Label(frame, text = "   ").grid(row = 4, column = 0)

# options for display ==================

detail_options = [
    "Standard",
    "Show more details"
]

def get_detail_level():
    global detail_level
    detail_level= time_opt.get()

detail_opt = StringVar()
detail_opt.set(detail_options[0])

detail_drop = OptionMenu(frame, detail_opt, *detail_options)
detail_drop.grid(row = 5, column = 0)

# get results ==================

label2 = Label(frame, text = "   ").grid(row = 6, column = 0)
def get_period():
    yr = float(e.get())
    if yr < 0:
        res_label = Label(frame_res, text="Welcome to future")
        res_label.pack()
    elif yr > 4600:
        res_label = Label(frame_res, text=str(yr) + " Ma: " + "Earth was not there yet.")
        res_label.pack()
    elif yr == 0:
        res_label = Label(frame_res, text="0 Ma: It is now.")
        res_label.pack()
    else:
        with open('geotime.csv') as csvfile:
            readCSV = csv.reader(csvfile, delimiter=',')
            header = next(readCSV)
            global res
            res = {}
            if header != None:
                for row in readCSV:
                    if yr >= float(row[2]) and yr < float(row[3]):
                        res['age'] = row[1]
                        res['t_age'] = row[2]
                        res['b_age'] = row[3]
                        res['age_color'] = row[4]
                        res['epoch'] = row[5]
                        res['t_epoch'] = row[6]
                        res['b_epoch'] = row[7]
                        res['epoch_color'] = row[8]
                        res['period'] = row[9]
                        res['t_period'] = row[10]
                        res['b_period'] = row[11]
                        res['period_color'] = row[12]
                        res['era'] = row[13]
                        res['era_color'] = row[14]
                        res['eon'] = row[15]
                        res['eon_color'] = row[16]
        if detail_opt.get() == 'Standard':
            if time_opt.get() == 'Period':
                res_label_pre = Label(frame_res, text = str(yr) + " Ma: ").pack()
                output_text = "Period: " + res['period']
                res_label = Label(frame_res, text=output_text)
                res_label.pack()
                es_label_post = Label(frame_res, text="    ").pack()
            elif time_opt.get() == 'Epoch':
                res_label_pre = Label(frame_res, text = str(yr) + " Ma: ").pack()
                output_text = "Epoch: " + res['epoch']
                res_label = Label(frame_res, text=output_text)
                res_label.pack()
                es_label_post = Label(frame_res, text="    ").pack()
            elif time_opt.get() == 'Age':
                res_label_pre = Label(frame_res, text = str(yr) + " Ma: ").pack()
                output_text = "Age: " + res['age']
                res_label = Label(frame_res, text=output_text)
                res_label.pack()
                es_label_post = Label(frame_res, text="    ").pack()
            else:
                res_label_pre = Label(frame_res, text=str(yr) + " Ma: ").pack()
                output_text1 = "Eon: " + res['eon']
                output_text2 = "Era: " + res['era']
                output_text3 = "Period: " + res['period']
                output_text4 = "Epoch: " + res['epoch']
                output_text5 = "Age: " + res['age']
                res_label1 = Label(frame_res, text=output_text1).pack()
                res_label2 = Label(frame_res, text=output_text2).pack()
                res_label3 = Label(frame_res, text=output_text3).pack()
                res_label4 = Label(frame_res, text=output_text4).pack()
                res_label5 = Label(frame_res, text=output_text5).pack()
                res_label_post = Label(frame_res, text="    ").pack()
        else:
            if time_opt.get() == 'Period':
                res_label_pre = Label(frame_res, text = str(yr) + " Ma: ").pack()
                output_text = "Period: " + res['period'] +"; " + res['b_period'] + ' ~ ' + res['t_period'] +" Ma; " + res['period_color']
                res_label = Label(frame_res, text=output_text).pack()
                es_label_post = Label(frame_res, text="    ").pack()
            elif time_opt.get() == 'Epoch':
                res_label_pre = Label(frame_res, text = str(yr) + " Ma: ").pack()
                output_text = "Epoch: " + res['epoch']+"; " + res['b_epoch'] + ' ~ ' + res['t_epoch'] +" Ma; " + res['epoch_color']
                res_label = Label(frame_res, text=output_text)
                res_label.pack()
                es_label_post = Label(frame_res, text="    ").pack()
            elif time_opt.get() == 'Age':
                res_label_pre = Label(frame_res, text = str(yr) + " Ma: ").pack()
                output_text = "Age: " + res['age']+"; " + res['b_age'] + ' ~ ' + res['t_age'] +" Ma; " + res['age_color']
                res_label = Label(frame_res, text=output_text)
                res_label.pack()
                es_label_post = Label(frame_res, text="    ").pack()
            else:
                res_label_pre = Label(frame_res, text=str(yr) + " Ma: ").pack()
                output_text1 = "Eon: " + res['eon'] +"; " + res['eon_color']
                output_text2 = "Era: " + res['era']+"; " + res['era_color']
                output_text3 = "Period: " + res['period']+"; " + res['b_period'] + ' ~ ' + res['t_period'] +" Ma; " + res['period_color']
                output_text4 = "Epoch: " + res['epoch']+"; " + res['b_epoch'] + ' ~ ' + res['t_epoch'] +" Ma; " + res['epoch_color']
                output_text5 = "Age: " + res['age']+"; " + res['b_age'] + ' ~ ' + res['t_age'] +" Ma; " + res['age_color']
                res_label1 = Label(frame_res, text=output_text1).pack()
                res_label2 = Label(frame_res, text=output_text2).pack()
                res_label3 = Label(frame_res, text=output_text3).pack()
                res_label4 = Label(frame_res, text=output_text4).pack()
                res_label5 = Label(frame_res, text=output_text5).pack()
                res_label_post = Label(frame_res, text="    ").pack()

def all_children (frame_res) :
    _list = frame_res.winfo_children()
    for item in _list :
        if item.winfo_children() :
            _list.extend(item.winfo_children())
    return _list


showButton = Button(frame, text = "Show Interval", command = get_period, fg = "blue", width = 15)
showButton.grid(row = 9, column = 0)

label4 = Label(frame, text = "   ").grid(row = 10, column = 0)

def clearScreen():
    widget_list = all_children(frame_res)
    for item in widget_list:
        item.pack_forget()

def clearAbout():
    widget_list = all_children(frame_about)
    for item in widget_list:
        item.pack_forget()

fileMenu.add_command(label="Clear results", command = clearScreen)
fileMenu.add_command(label="Clear about", command = clearAbout)
editMenu.add_command(label="Data", command = aboutData)
editMenu.add_command(label="Author", command = aboutAuthor)


# calculator ================

res_label_clr = Label(frame, text="Calculator").grid(row = 13, column = 0)

e2 = Entry(frame_calc, width = 20, bg = "gray80", fg = "black", borderwidth = 5)
e2.grid(row = 0, column = 0, columnspan = 3, padx = 10, pady = 10)

def button_click(num):
    current = e2.get()
    e2.delete(0, END)
    e2.insert(0, str(current) + str(num))

def button_add_func():
    num1 = e2.get()
    global f_num
    global math
    math = "+"
    f_num = float(num1)
    e2.delete(0,END)

def button_minus_func():
    num1 = e2.get()
    global f_num
    global math
    math = "-"
    f_num = float(num1)
    e2.delete(0,END)

def button_multi_func():
    num1 = e2.get()
    global f_num
    global math
    math = "x"
    f_num = float(num1)
    e2.delete(0,END)

def button_div_func():
    num1 = e2.get()
    global f_num
    global math
    math = "/"
    f_num = float(num1)
    e2.delete(0,END)

def button_equal_func():
    num2 = e2.get()
    e.delete(0,END)
    if math == "+":
        e2.insert(0, f_num + float(num2))
    elif math == "-":
        e2.insert(0, f_num - float(num2))
    elif math == "x":
        e2.insert(0, f_num * float(num2))
    else:
        e2.insert(0, f_num / float(num2))

def button_clear_func():
    e2.delete(0,END)
    f_num = 0

# define buttons

button_1 = Button(frame_calc, text = "1",  width = 10, height = 3, command = lambda: button_click(1))
button_2 = Button(frame_calc, text = "2",  width = 10, height = 3,  command = lambda: button_click(2))
button_3 = Button(frame_calc, text = "3",  width = 10, height = 3,  command = lambda: button_click(3))
button_4 = Button(frame_calc, text = "4",  width = 10, height = 3,  command = lambda: button_click(4))
button_5 = Button(frame_calc, text = "5",  width = 10, height = 3,  command = lambda: button_click(5))
button_6 = Button(frame_calc, text = "6",  width = 10, height = 3,  command = lambda: button_click(6))
button_7 = Button(frame_calc, text = "7",  width = 10, height = 3,  command = lambda: button_click(7))
button_8 = Button(frame_calc, text = "8",  width = 10, height = 3,  command = lambda: button_click(8))
button_9 = Button(frame_calc, text = "9",  width = 10, height = 3,  command = lambda: button_click(9))
button_0 = Button(frame_calc, text = "0",  width = 10, height = 3,  command = lambda: button_click(0))
button_dot = Button(frame_calc, text = ".",width = 10, height = 3,  command = lambda: button_click("."))

button_add =Button(frame_calc, text = "+",  width = 10, height = 3, command = button_add_func)
button_minus =Button(frame_calc, text = "-",  width = 10, height = 3,  command = button_minus_func)
button_multi =Button(frame_calc, text = "x",  width = 10, height = 3,  command = button_multi_func)
button_div =Button(frame_calc, text = "÷",  width = 10, height = 3, command = button_div_func)
button_equal =Button(frame_calc, text = "=",  width = 20, height = 3,  command = button_equal_func)
button_clear =Button(frame_calc, text = "clear",  width = 10, height = 3, command = button_clear_func)

# put buttons on the screen

button_1.grid(row =3, column =0 )
button_2.grid(row =3, column =1 )
button_3.grid(row =3, column =2 )

button_4.grid(row =2, column =0 )
button_5.grid(row =2, column =1 )
button_6.grid(row =2, column =2 )

button_7.grid(row =1, column =0)
button_8.grid(row =1, column =1)
button_9.grid(row =1, column =2)

button_0.grid(row =4, column =1)
button_equal.grid(row =6, column =1, columnspan = 2)
button_add.grid(row =4, column =2 )
button_div.grid(row =5, column =0)
button_multi.grid(row =5, column =1 )
button_minus.grid(row =5, column =2 )
button_clear.grid(row =6, column =0)
button_dot.grid(row=4, column = 0)

# end calculator ======

# period to time=======

res_label_pre = Label(frame_pt, text="Find by interval name").pack()

e3 = Entry(frame_pt, width = 20, bg = "gray80", fg = "black", borderwidth = 5)
e3.pack()

def get_interval():
    iv = e3.get()
    with open('intervals.csv') as csvfile:
        readCSV = csv.reader(csvfile, delimiter=',')
        header = next(readCSV)
        global interval
        interval = {}
        if header != None:
            for row in readCSV:
                if str(iv) == str(row[1]):
                    interval['name'] = str(row[1])
                    interval['abbrev'] = str(row[2])
                    interval['t_age'] = str(row[3])
                    interval['b_age'] = str(row[4])
                    interval['type'] = str(row[5])
                    interval['color'] = str(row[6])
        if not interval:
            res_label0 = Label(frame_res, text="  ").pack()
            int_label1_text = "This is not an interval name."
            res_label1 = Label(frame_res, text=int_label1_text).pack()
        else:
            int_label1_text = "Name: " + interval['name'] + " " + interval['abbrev']
            int_label2_text = "Type: " + interval['type']
            int_label3_text = "Duration: " + interval['b_age'] + " ~ " + interval['t_age']
            int_label4_text = "Color: " + interval['color']
            res_label0 = Label(frame_res, text="  ").pack()
            res_label1 = Label(frame_res, text=int_label1_text).pack()
            res_label2 = Label(frame_res, text=int_label2_text).pack()
            res_label3 = Label(frame_res, text=int_label3_text).pack()
            res_label4 = Label(frame_res, text=int_label4_text).pack()

showInt= Button(frame_pt, text = "Find Interval", command = get_interval, fg = "blue", width = 15)
showInt.pack()

# clear=======

res_label_clr = Label(frame, text="  ").grid(row = 15, column = 0)

clearButton = Button(frame, text="Clear Results", command=clearScreen,  fg = "red", width = 15)
clearButton.grid(row = 16, column = 0)

root.mainloop()