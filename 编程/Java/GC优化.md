**Xms 是指设定程序启动时占用内存大小。**       一般来讲，这个值大点，程序会启动的快一点，但是也可能会导致机器暂时间变慢。

**Xmx 是指设定程序运行期间最大可占用的内存大小。** 如果程序运行需要占用更多的内存，超出了这个设置值，就会抛出OutOfMemory异常。

**Xss 是指设定每个线程的堆栈大小。** 这个就要依据你的程序，看一个线程大约需要占用多少内存，可能会有多少线程同时运行等。