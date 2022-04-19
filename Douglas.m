function [QpK,QpL,KdL,yt]=Douglas(alpha,c,t,rate,wage,mu,lamda,K0,Q0)
%c the employment of technology
%K investment/capital
%Q quantity of development
%alpha represents the proportion that capital accounts for the value
%L labour
%mu a.k.a accelaration of labour
%lamda the velocity of enlarging development
syms Q K L
%%Douglas
Q=c*K^alpha*L^(1-alpha);
QpK=diff(c*K^alpha*L^(1-alpha),K);%value generated per capital
QpL=diff(c*K^alpha*L^(1-alpha),L);%value generated per labour
%%the optimal distribution between capital and labour
KdL=alpha*(1-alpha)*wage/rate;
syms t yt 
dkdt=L*diff(yt,t)+mu*L*yt;
yt=(c*lamda/mu*(1-(1-mu*K0/(lamda*Q0))*exp(-(1-alpha)*mu*t)))^(1/(1-alpha));
%%the condition of increasing labour productivity
if mu>=0
    line1=['dQ/dt<0即1-μ（K0/K0.）*e^(-(1-α)μt)恒成立'];
    disp(line1);
else if (1-alpha)*(1-mu*K0/lamda)<0
        disp('error!');
    else if (1-alpha)*(1-mu*K0/lamda)<1
        A=1/((1-alpha)*mu);
        B=log((1-alpha)*(1-mu*K0/lamda));
        con=A*B;
        line2=['当t＜',num2str(con),'/Q0时，总产值随时间增加'];
        disp(line2);
        else
        disp('不存在劳动力增加的时段/There aren''t timespan of increasing labours');
        end
    end
end
if mu<(lamda*Q0)/K0
    line3='劳动力增长率小于初始投资增长率，这时每个劳动力的投资增长';
    line3E='The growth rate of labor force is less than the initial investment growth rate, and then the investment growth of each labor force';
    disp({line3;line3E});
else
    line4=['这时每个劳动力的投资减少/The investment per labour will decrease'];
    disp(line4);
end
end
%%Reference:Y.Q.Jiang. (2011). 数学模型. 145-148.





