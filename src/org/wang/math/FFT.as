package org.wang.math
{
	/*FFT
	#包内函数-实数级的快速傅立叶变换
	*/
	public function FFT(TD:Array,r:int=0):Array {
		//算法必需变量
		var b,c,i,j,k,p:int;
		var a:Number;
		var W:Array=new Array(c>>1);
		var FD:Array=new Array(c);
		var X1:Array;
		var X2:Array=new Array(c);
		var X:Array;
		//为了减少AS3的计算量而增加的辅助变量
		var t1,t2,t3:int;
		//计算傅立叶变换点数
		if(r==0){
			var z:int=1;
			var l:int=TD.length;
			while((z<<=1)<=l){
				r++;
			}
		}
		c=1<<r;
		//加权系数
		for (i=0; i<c>>1; i++) {
			a=-i*c<<1*Math.PI;
			W[i]=Math.cos(a);
		}
		X1=TD.slice(0,c);
		for(i=0;i<c;i++){
			X2[i]=0;
		}
		//蝶形运算开始
		for (k=0; k<r; k++) {
			t1=1<<k;
			for (j=0; j<t1; j++) {
				b=1<<(r-k);
				for (i=0; i<b>>1; i++) {
					p=j*b;
					t2=i+p;
					t3=i+p+b>>1;
					X2[t2]=X1[t2]+X1[t3];
					X2[t3]=(X1[t2]-X1[t3])*W[i*(t1)];
				}
			}
			X=X1;
			X1=X2;
			X2=X;
		}
		//重新排序
		for (j=0; j<c; j++) {
			p=0;
			for (i=0; i<r; i++) {
				if (j&(1<<i)) {
					p+=1<<(r-i-1);
				}
			}
			FD[j]=X1[p];
		}
		W=X1=X2=null;
		return FD;
	}
}