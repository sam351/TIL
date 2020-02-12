import os

# os.path.abspath
print('>>> os.path.abspath')
print("os.path.abspath('') : ",         os.path.abspath(''))
print("os.path.abspath(__file__) : ",   os.path.abspath(__file__))
print("os.path.abspath('__file__') : ", os.path.abspath('__file__'))
print()

# os.path.dirname
print('>>> os.path.dirname')
print("os.path.dirname('') : ",       os.path.dirname(''))
print("os.path.dirname(__file__) : ", os.path.dirname(__file__))
print()

# os.path.dirname( os.path.abspath )
print('>>> os.path.dirname( os.path.abspath )')
print("os.path.dirname(os.path.abspath('')) : ",       os.path.dirname(os.path.abspath('')))
print("os.path.dirname(os.path.abspath(__file__)) : ", os.path.dirname(os.path.abspath(__file__)))
print()

# os.getcwd
print('>>> os.getcwd')
print("os.getcwd() : ", os.getcwd())