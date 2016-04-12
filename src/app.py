from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    redis.incr('hits')

    return 'Vinc xiugai test-build4 I have been show_1 new sss  %s times.'  % redis.get('hits')

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True) 
