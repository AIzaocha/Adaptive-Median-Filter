%% ��������Ӧ��ֵ�˲�����ͼ��ȥ�봦��
clear all;
close all;
clc;
img=rgb2gray(imread('Lena.jpg'));       %��ԭͼת�ɻҶ�ͼ��
figure;imshow(img,[]);title('ԭͼ');     %��ʾԭʼͼ��
[m n]=size(img);            %m,nΪͼ�������������
img=imnoise(img,'salt & pepper',0.2);   %����20%�Ľ�������
figure;imshow(img,[]);title('����20%�Ľ�������');     %��ʾ���뽷���������ͼ��

%% ͼ���Ե��չ
%Ϊ��֤��Ե�����ص���Ա��ɼ����������ԭͼ����������չ��
%һ�����õ�����˲�����Ϊ7������ֻ��Ҫ���������Ҹ���չ3�����ؼ��ɲɼ�����Ե���ء�
Nmax=3;        %ȷ�����������չΪ3���أ�����󴰿�Ϊ7*7
imgn=zeros(m+2*Nmax,n+2*Nmax);      %�½�һ����չ���С��ȫ0����
imgn(Nmax+1:m+Nmax,Nmax+1:n+Nmax)=img;  %��ԭͼ������imgn�����м�
%���濪ʼ������չ�����ѱ�Ե���������⸴��
imgn(1:Nmax,Nmax+1:n+Nmax)=img(1:Nmax,1:n);                 %��չ�ϱ߽�
imgn(1:m+Nmax,n+Nmax+1:n+2*Nmax)=imgn(1:m+Nmax,n+1:n+Nmax);    %��չ�ұ߽�
imgn(m+Nmax+1:m+2*Nmax,Nmax+1:n+2*Nmax)=imgn(m+1:m+Nmax,Nmax+1:n+2*Nmax);    %��չ�±߽�
imgn(1:m+2*Nmax,1:Nmax)=imgn(1:m+2*Nmax,Nmax+1:2*Nmax);       %��չ��߽�
% figure;imshow(uint8(imgn));
re=imgn;        %��չ֮���ͼ��

%% �õ��������������ֵ
for i=Nmax+1:m+Nmax
    for j=Nmax+1:n+Nmax
        r=1;                %��ʼ��������1���أ����˲����ڴ�СΪ3
        while r~=Nmax+1    %���˲�����С�ڵ���7ʱ����������Ԫ��С��4���أ�
            W=imgn(i-r:i+r,j-r:j+r);
            W=sort(W(:));           %�Դ����ڻҶ�ֵ����������Ϊһά����
            Imin=min(W(:));         %��С�Ҷ�ֵ
            Imax=max(W(:));         %���Ҷ�ֵ
            Imed=W(ceil((2*r+1)^2/2));      %�Ҷ��м�ֵ
            if Imin<Imed && Imed<Imax       %�����ǰ������ֵ���������㣬��ô���ô˴ε���ֵΪ�滻ֵ
               break;
            else
                r=r+1;              %�������󴰿ڣ������жϣ�Ѱ�Ҳ������������ֵ
            end          
        end
        
 %% �жϵ�ǰ�����ڵ����������Ƿ�Ϊ�������Ǿ���ǰ��õ�����ֵ�滻�������滻       
        if Imin<imgn(i,j) && imgn(i,j)<Imax         %�����ǰ������ز���������ԭֵ���
            re(i,j)=imgn(i,j);
        else                                        %�������������ֵ
            re(i,j)=Imed;
        end
    end
end
%��ʾ���뽷��������ͼ��ͨ������Ӧ��ֵ�˲�����Ľ��
figure;imshow(re(Nmax+1:m+Nmax,Nmax+1:n+Nmax),[]);