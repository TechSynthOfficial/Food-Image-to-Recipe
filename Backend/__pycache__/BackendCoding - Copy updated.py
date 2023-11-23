from keras import models
import numpy as np
import cv2
import torch
import psycopg2
import sys
from psycopg2 import Error
import psycopg2.extras as extras
from flask import Flask,request,jsonify

#Connecting Database



conn = None
try:
    # connect to the PostgreSQL server
    print('Connecting to the PostgreSQL database...')
    conn = psycopg2.connect(**params_dic)
    if conn:
        print("DB Connected")
        cursor = conn.cursor()
except (Exception, psycopg2.DatabaseError) as error:
    print(error)
    sys.exit(1)


alllabels = [
    'aloo_matar', 'aloo_methi', 'bhindi_masala', 'Biryani',
    'Burger', 'butter_Chicken', 'Chai', 'chana_masala', 'chicken_tikka',
    'gajar_ka_halwa', 'gulab_Jamun', 'Haleem', 'Jalebi', 'kadhi_Pakoda',
    'Karahi', 'Kheer', 'Kulfi', 'Lassi', 'Nihari', 'Samosa','Samosa','Samosa','Samosa'
]

ingredient_list = []
method_list = []
names=[]

def search_query(predvalue):
    names.clear()
    ingredient_list.clear()
    method_list.clear()
    SQ=[]
    query = "SELECT * FROM %s" % (predvalue)
    try:
        cursor.execute(query)
        conn.commit()
        recipes = cursor.fetchall()
        totalrecipes = len(recipes)

        for recipe in recipes:
            na=recipe[1]
            names.append(na)
            ingredients = recipe[2]
            ingredient_list.append(ingredients)
            methods = recipe[3]
            method_list.append(methods)
            
    

    except (Exception, psycopg2.DatabaseError) as error:
        print("Error: %s" % error)
        conn.rollback()
    return names,ingredient_list,method_list

def load_yolo_model():
    model = torch.hub.load('ultralytics/yolov5', 'custom',path=r"Use your yolo model file here")
    return model
def load_model():
    model = models.load_model("Use your second model file here")
    return model
def reshaping(img):
    img = cv2.resize(img, (128, 128))
    img = np.reshape(img, (-1, 128, 128, 3))
    return img
def predictype(model,image_path):
    image = cv2.imread(image_path)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image = reshaping(image)
    predictions = model.predict(image)
    result=''
    for i in predictions:
        MaxElement = np.argmax(i)
        if MaxElement == 0:
            result="Food"
        else:
            result = "NonFood"
    return result
def yolopred(model,image_path):
    image = cv2.imread(image_path)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image = cv2.resize(image, (640, 640))
    result = model(image)
    return result
def extract_label(result):
    print(result)
    pd = result.pandas().xyxy[0]
    print(pd)
    labelid = pd['class'][0]
    return alllabels[labelid]


model1 = load_model()
model2 = load_yolo_model()


app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    file = request.files['image']
    completepath = r""
    file.save(completepath)
    imagetype = predictype(model1,completepath)
    print(imagetype)
    result = ''
    if imagetype == 'Food':
        result = yolopred(model2,completepath)
        pred = extract_label(result)
        print(pred)
        objects=search_query(pred)
        print(names)
        return jsonify({"label": pred, "objects": names,"ingred": ingredient_list,"method": method_list})
        
    else:
        return jsonify({"label": imagetype, "objects": [],"ingred":[],"method": []})


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')