clc; clear all; %10/12
x=linspace(0,12,100);
a1=trimf(x,[1 3 5]);
a2=trimf(x,[2 6 9]);
a3=trimf(x,[3 5 10]);
% plot(x,a1,'k'); hold on; plot(x,a2,'k'); hold on; plot(x,a3,'k')
% legend('a1','a2','a3')
K=[a1;a2;a3];
plot(x,K,'b','LineWidth',2)
%πως θα βρω πσο ανήκει ένα χ* σε κάθε σύνολο;
%Θα βάλω όπου χ το χ*
% ind=find(x==4.5)
%-------------------------------
%Αποασαφοποίηση
%Ας υποθέσουμε ότι τα παραπάνω σύνολα είναι στην έξοδο
x=linspace(0,12,100);
b1=trimf(x,[1 3 5]);
b2=trimf(x,[2 6 9]);
b3=trimf(x,[3 5 10]);
%Συμμετοχές ενός χ* σε Α1,Α2,Α3.
%Δηλαδή, w1=μΑ1(χ*)
w1=0.7; w2=0.3; w3=0.8;
%Κανόνες
%Αν x είναι Α1 τότε y είναι Β2
%Αν x είναι Α2 τότε y είναι Β3
%Αν x είναι Α3 τότε y είναι Β1
hold on;
plot(x,min(w1,b2),'r','LineWidth',3); hold on;
plot(x,min(w2,b3),'m','LineWidth',3); hold on;
plot(x,min(w3,b1),'k','LineWidth',3); hold on;
b1dash=min(w3,b1);
b2dash=min(w1,b2);
b3dash=min(w2,b3);
c=max(b1dash,max(b2dash,b3dash))
plot(x,c,'y','LineWidth',5) %το χ είναι έξοδος
y=defuzz(x,c,'centroid')
