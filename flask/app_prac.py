# ping-pong 혼자 실습하기

from flask import Flask
from flask import render_template
from flask import request
app = Flask(__name__)

@app.route('/my_features')
def get_name():
    return render_template('ping_my_features.html')

@app.route('/show_result')
def show_result():
    import random
    name = request.args.get('name')
    features = ['잘생김','착함','똑똑함','친절함','강함']
    samples = random.sample(features, 2)
    return render_template('pong_my_features.html', name=name, features=samples)


if __name__ == '__main__':
    app.run(debug=True)
