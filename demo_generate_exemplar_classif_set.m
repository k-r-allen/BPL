% Demo for generating new exemplars of a handwritten character given a single image.

% Parameters
run_id = 3; % can be numbers from 1...20
type_id = 'train'; % can be 'train' or 'test'
character_id = 5; % can be numbers from 1...20

nsamp = 9; % number of new exemplars to produce

% Load a previously fit set of motor programs
fn = makestr('classification/model_fits/run',run_id,'_',type_id,character_id,'_G');
if ~exist([fn,'.mat'],'file')
   fprintf(1,'File %s.mat not found.\n',fn);
   fprintf(1,'Please extract "model_fits.zip" so there is "model_fits" sub-directory in "classification". Program quiting...\n');
   return
end
load(fn,'G');
lib = loadlib;

% Sampling
[samples,types] = task_generate_exemplars_1overk(G,lib,nsamp);

% Show samples
figure;
sz = [428,622];
pos = get(gcf,'Position');
pos(3:4) = sz;
set(gcf,'Position',pos);
nrow = ceil(sqrt(nsamp));
subplot(nrow+1,nrow,floor((nrow+1)/2)); 
plot_image_only(G.img);
title('original');
for i=1:nsamp
   subplot(nrow+1,nrow,i+nrow); 
   I = samples{i}.pimg > 0.5;
   plot_image_only(I);
   if i==1
       title('new exemplars');
   end
end