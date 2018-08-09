
export CUDA_HOME=/usr/local/cuda
if [ -d $CUDA_HOME ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64
    export PATH=$CUDA_HOME/bin:$PATH
fi
