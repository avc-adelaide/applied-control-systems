%% encircle_ex.m

clear all
close all

s = tf('s');

figw = 20;
figh = 10;

figure(1);
figuresize(figw,figh,'centimeters')
G = (s+3)/(s-3);
xy = [3;4];
r = 2;
N = 11;
encirclement(G,xy,r,N,'G')
print -dpdf encirc1.pdf

figure(2);
figuresize(figw,figh,'centimeters')
G = (s+3)/(s-3);
xy = [3;0];
r = 2;
N = 11;
encirclement(G,xy,r,N,'G')
print -dpdf encirc2.pdf


figure(3);
figuresize(figw,figh,'centimeters')
G = (s+3)/(s-3);
xy = [0;1.5];
r = 2;
N = 7;
encirclement(G,xy,r,N,'G')
print -dpdf encirc3.pdf


figure(4);
figuresize(figw,figh,'centimeters')
G = (s+3)/(s-3);
xy = [-3;0];
r = 2;
N = 11;
encirclement(G,xy,r,N,'G')
print -dpdf encirc4.pdf

%%

t = 4.8;

figure(5);
figuresize(figw,figh,'centimeters')
axis([-t t -t t])
G = (s+3)/(s-3);
r = 2;
N = 21;
halfcirclement(G,r,N,'G')
print -dpdf encirc5.pdf

figure(6);
figuresize(figw,figh,'centimeters')
axis([-t t -t t])
G = (s+3)/(s-3);
r = 5;
N = 21;
halfcirclement(G,r,N,'G')
print -dpdf encirc6.pdf

figure(7);
figuresize(figw,figh,'centimeters')
axis([-t t -t t])
G = (s+3)/(s-3);
r = 10;
N = 21;
halfcirclement(G,r,N,'G')
print -dpdf encirc7.pdf

figure(8);
figuresize(figw,figh,'centimeters')
axis([-t t -t t])
G = (s+3)/(s-3);
r = 50;
N = 101;
halfcirclement(G,r,N,'G')
print -dpdf encirc8.pdf



