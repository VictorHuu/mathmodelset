X=input('自变量矩阵X=');
Y=input('因变量矩阵Y=');
n=size(X,2);
beta1=(n*X*Y'-sum(X)*sum(Y))/(n*X*X'-sum(X)^2);
beta0=mean(Y)-beta1*mean(X);
line1=['y=',num2str(beta1),'*x+',num2str(beta0)];
disp(line1);
deltae2=sum((beta1*X+beta0-Y).^2)/(n-2);
line2=['随机误差项方差的估计量δe2=',num2str(deltae2)];
disp(line2);
disp('回归方程的显著性检验');
disp('1.F检验');
U=sum((beta1*X+beta0-mean(Y)).^2);
Qe=sum((beta1*X+beta0-Y).^2);
F=U/(Qe/(n-2));
f=[161.448 18.513 10.128 7.709 6.608 5.987 5.591 5.318 5.117 4.965 4.844 4.747 4.667 4.600 4.543 ...
    4.494 4.451 4.414 4.381 4.351 4.325 4.301 4.279 4.260 4.242 4.225 4.210 4.196 4.183 4.171];
if F>f(1,n-2)
    disp('X与Y存在线性关系');
else
    disp('X与Y不存在线性关系');
end
disp('2.t检验');
Lxx=sum((X-mean(X)).^2);
sigmaecap=std(beta1*X+beta0);
T=sqrt(Lxx)*beta1/sigmaecap;
t=[12.706 4.303 3.182 2.776 2.571 2.447 2.365 2.306 2.262 2.228 2.201 2.179 2.16...
    2.145 2.131 2.12 2.11 2.101 2.093 2.086 2.08 2.074 2.069 2.064 2.06 0.056...
    2.052 0.048];
if abs(T)>t(n-2)
    disp('X与Y存在线性关系');
else
    disp('X与Y不存在线性关系');
end
disp('3.R检验');
r=sum((X-mean(X)).*(Y-mean(Y)))/sqrt((sum((X-mean(X)).^2)*sum((Y-mean(Y)).^2)));
disp(['相关系数r=',num2str(r)]);
if abs(r)>sqrt(1/(1+(n-2)/f(1,n-2)))
   disp('X与Y存在线性关系');
else
    disp('X与Y不存在线性关系');
end
lower0=beta0-t(1,n-2)*sigmaecap*sqrt(1/n+mean(X).^2/Lxx);
upper0=beta0+t(1,n-2)*sigmaecap*sqrt(1/n+mean(X).^2/Lxx);
disp(['β0置信水平为0.05的置信区间为：[',num2str(lower0),',',num2str(upper0),']']);
lower1=beta1-t(1,n-2)*sigmaecap/sqrt(Lxx);
upper1=beta1+t(1,n-2)*sigmaecap/sqrt(Lxx);
disp(['β1置信水平为0.05的置信区间为：[',num2str(lower1),',',num2str(upper1),']']);
deltax=@(x0)sigmaecap*t(1,n-2)*sqrt(1+1/n+(x0-mean(X)).^2/Lxx);
lowerd=beta1*X+beta0-deltax(X);
upperd=beta1*X+beta0+deltax(X);
hold on
xlabel('X');
ylabel('Y');
plot(X,Y,'r*');
plot(X,beta1*X+beta0,'b-');
plot(X,lowerd,'c');
plot(X,upperd,'c');
legend('实际值','预测值','预测区间下限','预测区间上限');
hold off 