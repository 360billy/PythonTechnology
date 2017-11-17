NumPy的数组中比较重要ndarray对象属性有：
ndarray.ndim：数组的维数（即数组轴的个数），等于秩。最常见的为二维数组（矩阵）。
ndarray.shape：数组的维度。为一个表示数组在每个维度上大小的整数元组。例如二维数组中，表示数组的“行数”和“列数”。ndarray.shape返回一个元组，这个元组的长度就是维度的数目，即ndim属性。
ndarray.size：数组元素的总个数，等于shape属性中元组元素的乘积。
ndarray.dtype：表示数组中元素类型的对象，可使用标准的Python类型创建或指定dtype。另外也可使用前一篇文章中介绍的NumPy提供的数据类型。
ndarray.itemsize：数组中每个元素的字节大小。例如，一个元素类型为float64的数组itemsiz属性值为8(float64占用64个bits，每个字节长度为8，所以64/8，占用8个字节），又如，一个元素类型为complex32的数组item属性为4（32/8）。
ndarray.data：包含实际数组元素的缓冲区，由于一般通过数组的索引获取元素，所以通常不需要使用这个属性。

先来介绍创建数组。创建数组的方法有很多。如可以使用array函数从常规的Python列表和元组创造数组。所创建的数组类型由原序列中的元素类型推导而来。　　　
[python] view plain copy 
>>> from numpy import *  
　　　  
>>> a = array( [2,3,4] )　　　  
>>> a  
    array([2, 3, 4])  
>>> a.dtype  
    dtype('int32')  
>>> b = array([1.2, 3.5, 5.1])　　　  
>>> b.dtype  
    dtype('float64')  
使用array函数创建时，参数必须是由方括号括起来的列表，而不能使用多个数值作为参数调用array。　　　
[python] view plain copy
>>> a = array(1,2,3,4)    # 错误  
>>> a = array([1,2,3,4])  # 正确  
可使用双重序列来表示二维的数组，三重序列表示三维数组，以此类推。
[python] view plain copy
>>> b = array( [ (1.5,2,3), (4,5,6) ] )　　  
>>> b  
    array([[ 1.5,  2. ,  3. ],  
　　　     [ 4. ,  5. ,  6. ]])  
可以在创建时显式指定数组中元素的类型
[python] view plain copy
>>> c = array( [ [1,2], [3,4] ], dtype=complex)  
>>> c  
    array([[ 1.+0.j,  2.+0.j],  
　　　    [ 3.+0.j,  4.+0.j]])  
通常，刚开始时数组的元素未知，而数组的大小已知。因此，NumPy提供了一些使用占位符创建数组的函数。这些函数有助于满足除了数组扩展的需要，同时降低了高昂的运算开销。
用函数zeros可创建一个全是0的数组，用函数ones可创建一个全为1的数组，函数empty创建一个内容随机并且依赖与内存状态的数组。默认创建的数组类型(dtype)都是float64。
可以哟娜特d.dtype.itemsize来查看数组中元素占用的字节数目。
[python] view plain copy
>>> d = zeros((3,4))  
>>> d.dtype  
dtype('float64')  
>>> d  
array([[ 0.,  0.,  0.,  0.],  
　　   [ 0.,  0.,  0.,  0.],  
　　   [ 0.,  0.,  0.,  0.]])  
>>> d.dtype.itemsize  
8  
也可以自己制定数组中元素的类型
[python] view plain copy
>>> ones( (2,3,4), dtype=int16 )  #手动指定数组中元素类型  
      array([[[1, 1, 1, 1],  
　　　        [1, 1, 1, 1],  
　　　        [1, 1, 1, 1]],  
　　　  
　　　       [[1, 1, 1, 1],  
　　　        [1, 1, 1, 1],  
　　　        [1, 1, 1, 1]]], dtype=int16)  
>>> empty((2,3))  
　　　array([[  2.65565858e-316,   0.00000000e+000,   0.00000000e+000],  
　　　       [  0.00000000e+000,   0.00000000e+000,   0.00000000e+000]])  
NumPy提供一个类似arange的函数返回一个数列形式的数组:
[python] view plain copy
>>> arange(10, 30, 5)  
    array([10, 15, 20, 25])  
以10开始，差值为5的等差数列。该函数不仅接受整数，还接受浮点参数：　
[python] view plain copy
>>> arange(0,2,0.5)  
    array([ 0. ,  0.5,  1. ,  1.5])  
当arange使用浮点数参数时，由于浮点数精度有限，通常无法预测获得的元素个数。因此，最好使用函数linspace去接收我们想要的元素个数来代替用range来指定步长。linespace用法如下，将在通用函数一节中详细介绍。
[python] view plain copy
>>> numpy.linspace(-1, 0, 5)  
        array([-1.  , -0.75, -0.5 , -0.25,  0.  ])  
数组中的元素是通过下标来访问的，可以通过方括号括起一个下标来访问数组中单一一个元素，也可以以切片的形式访问数组中多个元素。关于切片访问，将在切片一节介绍。


NumPy类型转换方式如下：
[python] view plain copy
>>> float64(42)  
    42.0  
>>> int8(42.0)  
    42  
>>> bool(42)  
    True  
>>> bool(42.0)  
    True  
>>> float(True)  
    1.0  
许多函数的参数中可以指定参数的类型，当然，这个类型参数是可选的。如下：
[python] view plain copy
>>> arange(7, dtype=uint16)  
    array([0, 1, 2, 3, 4, 5, 6], dtype=uint16)  
输出数组

    当输出一个数组时，NumPy以特定的布局用类似嵌套列表的形式显示：
第一行从左到右输出
每行依次自上而下输出
每个切片通过一个空行与下一个隔开
一维数组被打印成行，二维数组成矩阵，三维数组成矩阵列表。
 　　　
[python] view plain copy 
>>> a = arange(6)                         # 1d array  
>>> print a  
    [0 1 2 3 4 5]  
　　　  
>>> b = arange(12).reshape(4,3)           # 2d array  
>>> print b  
    [[ 0  1  2]  
    [ 3  4  5]  
    [ 6  7  8]  
    [ 9 10 11]]　　　  
>>> c = arange(24).reshape(2,3,4)         # 3d array  
>>> print c  
    [[[ 0  1  2  3]  
    [ 4  5  6  7]  
    [ 8  9 10 11]]  
　　　  
    [[12 13 14 15]  
    [16 17 18 19]  
    [20 21 22 23]]]  
    reshape将在下一篇文章中介绍　
    如果一个数组太长，则NumPy自动省略中间部分而只打印两端的数据：　　　
[python] view plain copy 
>>> print arange(10000)  
　　　[   0    1    2 ..., 9997 9998 9999]  
　　　  
>>> print arange(10000).reshape(100,100)  
　　　[[   0    1    2 ...,   97   98   99]  
　　　 [ 100  101  102 ...,  197  198  199]  
　　　 [ 200  201  202 ...,  297  298  299]  
　　　 ...,  
　　　 [9700 9701 9702 ..., 9797 9798 9799]  
　　　 [9800 9801 9802 ..., 9897 9898 9899]  
　　　 [9900 9901 9902 ..., 9997 9998 9999]]  

　　可通过设置printoptions参数来禁用NumPy的这种行为并强制打印整个数组。
[python] view plain copy 
set_printoptions(threshold='nan')
