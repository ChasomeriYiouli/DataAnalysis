from db1 import connection
import numpy as np 
import pandas as pd 

cursor = connection.CONNECTION.cursor()
cursor2= connection.CONNECTION_DW.cursor()


#################################INSERTING VALUES IN DATA WAREHOUSE########################################
# cursor.execute('SELECT * FROM FLOOR')
# Floor = cursor.fetchall()
# print Floor
# for f in Floor:
#     cursor2.execute('''INSERT INTO DIM_FLOOR (FloorID,FloorDescription) values (?,?)''', f)
#     cursor2.commit() 


# cursor.execute('SELECT * FROM BUILDING')
# Floor = cursor.fetchall()
# print Floor
# for f in Floor:
#     cursor2.execute('''INSERT INTO DIM_BUILDING_ID (BuildingID,BuildingName) values (?,?)''', f)
#     cursor2.commit() 

# cursor.execute('SELECT * FROM TRADE')
# item = cursor.fetchall()
# print item
# for it in item:
#     cursor2.execute('''INSERT INTO DIM_TRADE (TradeID,TradeDescription) values (?,?)''', it)
#     cursor2.commit() 

cursor.execute('SELECT * FROM CONSTRUCTION_ELEMENTS')
item = cursor.fetchall()
# print item[0]
elements = []
for it in item :
    elements.append(it)  
print elements
# for e in elements:
#       cursor2.execute('''INSERT INTO DIM_Constr_elements (con_elem_part, con_elem_id) values (?,?)''', e[1:])
#       cursor2.commit() 


# cursor.execute('SELECT * FROM Construction_elements_families')
# item = cursor.fetchall()
# # print item
# elements = []
# for it in item :
#     elements.append(it[1])  
# # print elements
# for e in elements:
#       cursor2.execute('''INSERT INTO DIM_Constr_element_fam (con_element_family) values (?)''', e)
#       cursor2.commit() 


# cursor.execute('SELECT * FROM Construction_elements_types')
# item = cursor.fetchall()
# # print item
# elements = []
# for it in item :
#     elements.append(it)  
# # print elements
# for e in elements:
#       cursor2.execute('''INSERT INTO DIM_Constr_element_type (con_element_type, con_fam_id) values (?,?)''', e[1:])
#       cursor2.commit() 


###################################################CORRECT DATA AND BRING THEM TO DATABASE#######################################

################CORRECT BOQ#################
# cursor.execute('SELECT * FROM BOQ')
# item = cursor.fetchall()
# BOQ = []
# new_item = []
# for it in item:
#     if it[2]=='Polystyrene Insulation(DOW) 3cm':
#        it[2] = 'Polystyrene Insulation, DOW 3cm'
#     elif it[2]== 'Reinforcement for Columns-B500C':
#         it[2] = 'Reinforcement for Columns - B500C'
#     elif it[2]== 'Reinforcement for ConcreteWalls- B500C':
#         it[2] ='Reinforcement for ConcreteWalls - B500C'
#     elif it[2]=='Wat.Pr. Admixtures for Ret.Wall and external basement columns':
#         it[2] ='Water Proof Admixtures for Retaining Wall and external basement columns'
#     elif it[5]== 'Bituminous WP Paint':
#         it[5] = 'Bituminous WaterProof Paint'
#     elif it[5]== 'Formwork for Columns,CW & RW':
#         it[5] ='Formwork for Columns,Con. Walls & Ret. Walls'
#     elif it[5]=='Wat.Pr. Admixtures for Ret.Wall':
#         it[5] ='WaterProof Admixtures for Ret. Wall'
#     elif not it[3]:    #np.isnan(it[3]):
#         it[3] = 0
#     new_item.append(it)
  
    
# # cursor2.execute('''INSERT INTO DIM_BOQ (BOQ_Category,BOQ_DESCRIPTION,Unit_Price,Unit,BOQ) values (?,?,?,?,?)''',i[1:])
# # cursor2.commit()

# #print len(item)
# #print len(BOQ)

# # print item

# # print len(item)
# for i in new_item:
#     cursor2.execute('''INSERT INTO DIM_BOQ (BOQ_Category,BOQ_DESCRIPTION,Unit_Price,Unit,BOQ) values (?,?,?,?,?)''',i[1:])
    # cursor2.commit()

##################################### Schedule

# cursor.execute ('SELECT * from schedule')
# schedule = cursor.fetchall()
# # print schedule[0]
# from datetime import datetime
 
# substrings = ['BO','RF','L0','L1','L2']
# clean_data=[]
# for res in schedule:
#   oldformat1 = str(res[0])
#   datetimeobject1 = datetime.strptime(oldformat1,'%m/%d/%Y')
#   newformat1 = datetimeobject1.strftime('%d-%m-%Y')
#   x = datetimeobject1.month
#   if x <= 3:
#       quarter = 'Q1'
#   elif x <=6 and x >3:
#       quarter = 'Q2'
#   elif x <= 9 and x>6:
#       quarter = 'Q3'
#   else:
#       quarter = 'Q4'
#   # res.append(quarter)    
#   res[0] = newformat1      
#   oldformat2 = str(res[1])
#   datetimeobject2 = datetime.strptime(oldformat2,'%m/%d/%Y')
#   newformat2 = datetimeobject2.strftime('%d-%m-%Y')
#   res[1] = newformat2
#   i = res [3]
#   for s in substrings:
#      if s in i:
#       #    print i
#          i = i.replace(s,'')
#       #    print i
#   res[3] = i    
#   resfinal = list(res)
#   resfinal = resfinal[:-3]  
#   resfinal.append(quarter)
#   clean_data.append(resfinal)
# print clean_data [0]
# clean_data_final = []
# for i in clean_data:
    # print i
    # i.pop(4)
    # print i
    # clean_data_final.append(i)
# print len(clean_data_final)
# print clean_data_final 
# for i in clean_data_final:
    # print i
    # q = '''INSERT INTO DIM_schedule (start,finish,cost_overrun,delay,scope_id,con_elem_type_id,activity_id,BOQID,scope_elem_type_boq,quarter) 
    #   values (?,?,?,?,?,?,?,?,?,?)'''
    # cursor2.execute('''INSERT INTO DIM_schedule (start,finish,cost_overrun,delay,scope_id,con_elem_type_id,activity_id,BOQID,scope_elem_type_boq,quarter) 
    #   values (?,?,?,?,?,?,?,?,?,?)''',i)
    # cursor2.commit()


# cursor.execute('SELECT * FROM SCOPE')
# Scope = cursor.fetchall()
# print Scope
# for s in Scope:
#     cursor2.execute('''INSERT INTO DIM_Scope (BuildingID,FloorID,TradeID) values (?,?,?)''', s[1:])
#     cursor2.commit() 


##################################### raw construction data

# cursor.execute ('SELECT * from rawconstructiondata')
# rcd = cursor.fetchall()
# # print rcd[0]

# clean_rcd = []

# for row in rcd:
#     a = row [:2]
#     b = row [3:7]
#     c = row [10:13]
#     d = row [14:]
#     my_list = list(a)+list(b)+list(c)+list(d)
#     # print my_list
#     clean_rcd.append(my_list)
# clean_rcd_final = []
# for row in clean_rcd:
#    l = row [-2]
#    if not l:
#        l = 0
#    l = round(float(l),2)
# #    print l
#    t = row [-3]
#    if not t:
#        t = 0
#    t = round(float(t),2)
#    # print t
#    h = row [-4]
#    if not h:
#        h = 0
#    h = round(float(h),2)
#    clean_rcd_final.append(row)
# # print clean_rcd[0]
# print clean_rcd_final[1]

# for r in clean_rcd_final:

#     cursor2.execute('''INSERT INTO FT_company_situation (quantity, total_cost,scope_id,con_elem_id, boq_id, scope_elem_type_boq,length, thickness, height, sid) 
#     values (?,?,?,?,?,?,?,?,?,?)''', r)
#     cursor2.commit() 
# # print rcd_final
# (quantity, total_cost,RCID, Scope, Construction_elem_id, boq_id, scope_elem_type_boq, x, y, z, length, thickness, height, id, SID)
# (quantity, total_cost,RCID, Scope, Construction_elem_id, boq_id, scope_elem_type_boq, x, y, z, length, thickness, height, id, SID)
# (scope, SID, BOQ, Con_elem_type_id, quant, total cost, scope ele type boq, length, thick, height)