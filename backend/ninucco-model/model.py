from dotenv import load_dotenv
import os
import s3fs
import tensorflow
import numpy as np
import tempfile
from operator import itemgetter

# load .env
load_dotenv()

AWS_ACCESS_KEY = os.environ.get('AWS_ACCESS_KEY')
AWS_SECRET_KEY = os.environ.get('AWS_SECRET_KEY')
BUCKET_NAME = os.environ.get('BUCKET_NAME')

def get_s3fs():
    return s3fs.S3FileSystem(key=AWS_ACCESS_KEY, secret=AWS_SECRET_KEY)


def get_models_and_classes():
    models = {}
    classes = {}

    with tempfile.TemporaryDirectory() as tempdir:
        s3fs = get_s3fs()
        model_names = list(filter(lambda x: x != '', [x.split('/')[-1] for x in s3fs.ls(f"{BUCKET_NAME}/model/")]))
        s3fs.get(f"{BUCKET_NAME}/model/",
                f"{tempdir}/model/", recursive=True)
        for model_name in model_names:
            models[model_name] = tensorflow.keras.models.load_model(
                f"{tempdir}/model/{model_name}/keras_model.h5", compile=False)

            classes[model_name] = []
            lables_path = f"{tempdir}/model/{model_name}/labels.txt"
            lables_file = open(lables_path, encoding='UTF-8')

            line = lables_file.readline()
            while line:
                classes[model_name].append(line.split(' ', 1)[1].rstrip())
                line = lables_file.readline()
            lables_file.close()
        return models, classes


def predict(img_dir, _model, _class):
    image = tensorflow.keras.utils.load_img(
        img_dir, target_size=(224, 224))
    input_arr = tensorflow.keras.utils.img_to_array(image)
    input_arr = np.array([input_arr])
    result = _model.predict(input_arr)[0]
    result_list = []
    for i in range(0, len(result)):
        result_list.append({'key': _class[i], 'value': result[i].item()})
    result_list = sorted(result_list, key=itemgetter('value'), reverse=True)
    
    return result_list
