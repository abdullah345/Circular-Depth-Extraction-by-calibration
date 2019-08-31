pic1=imread('dellorg.jpg');
pic2=imread('hpfl3.jpg');
vadell=130;
delia=35;
vahp=114;
hpia=21;
x=38.5;
apphp=vahp/1280;
hpra=541*apphp;
hpfa=hpra+hpia;


appdl=vadell/1280;
pix=[277,872];
delra=542*appdl;
delfulang=delra+delia;

z=(x*(sind(delfulang)))/(sind(180-(hpfa+delfulang)));
y=(z*sind(hpfa))/(sind(delfulang));

cnt=1;
graypic1=rgb2gray(pic1);
graypic2=rgb2gray(pic2);
edg = edge(graypic2,'prewitt');
[r,c]=size(graypic1);
[dx, dy] = imgradientxy(graypic2,'prewitt');

%angle and magnitude

for a=1:r-2
    for b=1:c-2
        dmagdell(a,b)=sqrt(double(dx(a,b)^2+dy(a,b)^2));
        
        dangdell(a,b)=(atand(double((dy(a,b))/(dx(a,b)))));
    end
end

%interestPoint , surrounding point nearest mil k ek desc banate hen

Kmedian=edg;cnt=1;
count=0;flag=0;row=0;col=0;grav=0;
for a=2:r-3
    for b=2:c-3
        if (Kmedian(a,b)==1)
            flag=0;
            if(Kmedian(a-1,b-1)==1)
            flag=flag+1;
            pointa=a-1;
            pointb=b-1; 
            end
            if(Kmedian(a-1,b)==1)
                 flag=flag+1;
                pointa=a-1;
                pointb=b;
            end
            
                if(Kmedian(a-1,b+1)==1)
                      flag=flag+1;
                    pointa=a-1;
                pointb=b+1;
                end
                    if(Kmedian(a,b-1)==1)
                          flag=flag+1;
                        pointa=a;
                        pointb=b;
                    end
                        if(Kmedian(a,b+1)==1)
                            pointa=a-1;
                              flag=flag+1;
                            pointb=b;
                        end
                            if(Kmedian(a+1,b-1)==1)
                                  flag=flag+1;
                                pointa=a+1;
                                 pointb=b-1;
                            end
                            
                                if(Kmedian(a+1,b)==1)
                                    pointa=a+1;
                                     flag=flag+1;
                                    pointb=b;
                                end
                                    if(Kmedian(a+1,b+1)==1)
                                        pointa=a+1;
                                         flag=flag+1;
                                        pointb=b+1;
                                    end
            if(flag>=2)% minimum 2 pixels pe 
                if((dangdell(a,b)-dangdell(pointa,pointb))>50)
                    
                     row(cnt)=a;
                     col(cnt)=b;
                     desgrav(cnt)=graypic2(a,b);
                     cnt=cnt+1;
                    end
                end
            end
            
        end
    end

int=table(row,col,grav); %interest point ka table

%descriptor
desrow=0;
descol=0;
desgrav=0;
cnt=1;
check=0;dcount=0;
for  ea=1:1263
    vr=row(ea);
    vc=col(ea);
    check=0;
    for eb=1:1263
        if(vc==col(eb))
            if(row(eb)==vr-1)
                check=check+1;
            
            elseif(row(eb)==vr+1)
                check=check+1;
            end
            
        elseif(vc-1==col(eb))
            if(row(eb)==vr-1)
                check=check+1;
            elseif(row(eb)==vr+1)
                check=check+1;
            elseif(row(eb)==vr)
                check=check+1;
            end
        elseif(vc+1==col(eb))
            if(row(eb)==vr-1)
                check=check+1;
            
            elseif(row(eb)==vr+1)
                check=check+1;
                
            elseif(row(eb)==vr)
                check=check+1;
            end
            
            if(check~=0)
           
            desrow(cnt)=vr;
            descol(cnt)=vc;
            grav(cnt)=graypic2(vr,vc);
            cnt=cnt+1;
           
        end
        end
        
            
            
        
    end
end
               
                
 descriptor=table(desrow,descol,grav);   %descriptor ka table
 
 rs=pic1;
 
    
for a=2:r-1 %Bokeh Effect
    for b=2:c-4
            
        dc=b;
        hc=b+1;
        hpra=hc*apphp;
        hpfa=hpra+hpia;
        delra=dc*appdl;
        delfulang=delra+delia;
        z=(x*(sind(delfulang)))/(sind(180-(hpfa+delfulang)));
        y=(z*sind(hpfa))/(sind(delfulang));

        if(((y<36)&&(z<43))||((y>110)&&(z>118))) %distence face se pehle wala
            
            p1=rs(a,b,1)*((1/8.5));
            p2=rs(a-1,b-1,1)*((1/8.5));
            p3=rs(a-1,b,1)*((1/8.5));
            p4=rs(a-1,b+1,1)*((1/8.5));
            p5=rs(a,b-1,1)*((1/8.5));
            p6=rs(a,b+1,1)*((1/8.5));
            p7=rs(a+1,b,1)*((1/8.5));
            p8=rs(a+1,b,1)*((1/8.5));
            p9=rs(a+1,b+1,1)*((1/8.5));
            av=p1+p2+p3+p4+p5+p6+p6+p7+p8+p9;
            rs(a,b,1)=av;
            
            p1=rs(a,b,2)*((1/8.5));
            p2=rs(a-1,b-1,2)*((1/8.5));
            p3=rs(a-1,b,2)*((1/8.5));
            p4=rs(a-1,b+1,2)*((1/8.5));
            p5=rs(a,b-1,2)*((1/8.5));
            p6=rs(a,b+1,2)*((1/8.5));
            p7=rs(a+1,b,2)*((1/8.5));
            p8=rs(a+1,b,2)*((1/8.5));
            p9=rs(a+1,b+1,2)*((1/8.5));
            av=p1+p2+p3+p4+p5+p6+p6+p7+p8+p9;
            
            rs(a,b,2)=av;
            
            p2=rs(a-1,b-1,3)*((1/8.5));
            p3=rs(a-1,b,3)*((1/8.5));
            p4=rs(a-1,b+1,3)*((1/8.5));
            p5=rs(a,b-1,3)*((1/8.5));
            p6=rs(a,b+1,3)*((1/8.5));
            p7=rs(a+1,b,3)*((1/8.5));
            p8=rs(a+1,b,3)*((1/8.5));
            p9=rs(a+1,b+1,3)*((1/8.5));
            av=p1+p2+p3+p4+p5+p6+p6+p7+p8+p9;
            rs(a,b,3)=av;
            
            
       
        else %distence face k bad wala
            p1=rs(a,b,1)*(1/10);
            p2=rs(a-1,b-1,1)*(1/10);
            p3=rs(a-1,b,1)*(1/10);
            p4=rs(a-1,b+1,1)*(1/10);
            p5=rs(a,b-1,1)*(1/10);
            p6=rs(a,b+1,1)*(1/10);
            p7=rs(a+1,b,1)*(1/10);
            p8=rs(a+1,b,1)*(1/10);
            p9=rs(a+1,b+1,1)*(1/10);
            av=p1+p2+p3+p4+p5+p6+p6+p7+p8+p9;
            rs(a,b,1)=av;
            
             p1=rs(a,b,2)*(1/10);
            p2=rs(a-1,b-1,2)*(1/10);
            p3=rs(a-1,b,2)*(1/10);
            p4=rs(a-1,b+1,2)*(1/10);
            p5=rs(a,b-1,2)*(1/10);
            p6=rs(a,b+1,2)*(1/10);
            p7=rs(a+1,b,2)*(1/10);
            p8=rs(a+1,b,2)*(1/10);
            p9=rs(a+1,b+1,2)*(1/10);
            av=p1+p2+p3+p4+p5+p6+p6+p7+p8+p9;
            rs(a,b,2)=av;
            
             p1=rs(a,b,3)*(1/10);
            p2=rs(a-1,b-1,3)*(1/10);
            p3=rs(a-1,b,3)*(1/10);
            p4=rs(a-1,b+1,3)*(1/10);
            p5=rs(a,b-1,3)*(1/10);
            p6=rs(a,b+1,3)*(1/10);
            p7=rs(a+1,b,3)*(1/10);
            p8=rs(a+1,b,3)*(1/10);
            p9=rs(a+1,b+1,3)*(1/10);
            av=p1+p2+p3+p4+p5+p6+p6+p7+p8+p9;
            rs(a,b,3)=av;
        end
            end
    end


