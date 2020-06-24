
import os
from flask import Flask, flash, render_template, redirect, url_for, request, session
from database import Database


app = Flask(__name__)
app.secret_key = os.urandom(12)
db = Database()

@app.route('/')
def index():
    data = db.read(None, None)

    return render_template('index.html', data = data)

@app.route('/add/')
def add():
    return render_template('add.html')

@app.route('/addorder', methods = ['POST', 'GET'])
def addorder():
    if request.method == 'POST' and request.form['save']:
        if db.insert(request.form):
            flash("A new order has been added")
        else:
            flash("A new order cannot be added")

        return redirect(url_for('index'))
    else:
        return redirect(url_for('index'))

@app.route('/update/<id>,<line>/')
def update(id,line):
    data = db.read(id[2:-1], line[1:-1])
    print(id[2:-1])
    print(line[1:-1])
    print(len(data))
    if len(data) == 0:
        return redirect(url_for('index'))
    else:
        session['update'] = id[2:-1],line[1:-1]
        print(session['update'][0])
        print(session['update'][1])
        return render_template('update.html', data = data)

@app.route('/updateorder', methods = ['POST'])
def updateorder():
    if request.method == 'POST' and request.form['update']:

        if db.update(session['update'][0], session['update'][1], request.form):
            flash('An order has been updated')

        else:
            flash('An order cannot be updated')

        session.pop('update', None)

        return redirect(url_for('index'))
    else:
        return redirect(url_for('index'))

@app.route('/delete/<id>,<line>/')
def delete(id, line):
    data = db.read(id[2:-1], line[1:-1])

    if len(data) == 0:
        return redirect(url_for('index'))
    else:
        session['delete'] = id[2:-1],line[1:-1]
        return render_template('delete.html', data = data)

@app.route('/deleteorder', methods = ['POST'])
def deleteorder():
    if request.method == 'POST' and request.form['delete']:

        if db.delete(session['delete'][0], session['delete'][1]):
            flash('An order has been deleted')

        else:
            flash('An order cannot be deleted')

        session.pop('delete', None)

        return redirect(url_for('index'))
    else:
        return redirect(url_for('index'))

@app.errorhandler(404)
def page_not_found(error):
    return render_template('error.html')

if __name__ == '__main__':
    app.run(debug=True)
