function Ydata = CalculateD2dParameters(Lam,d,MM1,MM2,MM3);
%parameters that we will send into the algorithms are calculated below

%Calculate envelope on M23 and M24 on transmission measurement for
%measurement of OR
[M23U,M23L]=CalcM34Envelope(Lam,MM3(2,3,:));
[M24U,M24L]=CalcM34Envelope(Lam,MM3(2,4,:));

%Calculate envelope on M34 and M44 on refelction measurements
[M34U1,M34L1]=CalcM34Envelope(Lam,MM1(3,4,:));
[M44U1,M44L1]=CalcM34Envelope(Lam,MM1(4,4,:));
[M34U2,M34L2]=CalcM34Envelope(Lam,MM2(3,4,:));
[M44U2,M44L2]=CalcM34Envelope(Lam,MM2(4,4,:));

%Calculate periodicity of M44 for all measurements
[M44f1]=frequency(Lam,MM1(4,4,:));
[M44f2]=frequency(Lam,MM2(4,4,:));
[M44f3]=frequency(Lam,MM3(4,4,:));

%Calculate average value of M34 and M44 on reflection measurements
M34A1 = mean(MM1(3,4,:));
M44A1 = mean(MM1(4,4,:));
M34A2 = mean(MM2(3,4,:));
M44A2 = mean(MM2(4,4,:));

%Send in M12 and M21 for the reflection measurements

%Compile all data together
Ydata = zeros(22,length(Lam));
Ydata(1,:) = M23U./0.0238;
Ydata(2,:) = M23L./-0.0308;
Ydata(3,:) = M24U./0.0609;
Ydata(4,:) = M23L./-.0308;
Ydata(5,:) = M34U1./0.1335;
Ydata(6,:) = M34L1./-0.1335;
Ydata(7,:) = M44U1./0.335;
Ydata(8,:) = M44L1./0.067;
Ydata(9,:) = M34U2./0.4;
Ydata(10,:) = M34L2./0.4;
Ydata(11,:) = M44U2./-.48;
Ydata(12,:) = M44L2./0.85;
Ydata(13,:) = M44f1./32;
Ydata(14,:) = M44f2./66;
Ydata(15,:) = M44f3./164;
Ydata(16,:) = M34A1./-0.00322;
Ydata(17,:) = M44A1./.121;
Ydata(18,:) = M34A2./.012;
Ydata(19,:) = M44A2./.42;
Ydata(20,:) = MM2(1,2,:)./.5261;
Ydata(21,:) = MM3(1,2,:)./.0339;
Ydata(22,:) = MM1(1,2,:);
Ydata = Ydata';
end