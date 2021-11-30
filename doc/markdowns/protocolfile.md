**Example 1**

````MATLAB
blocks{1}.randomization=0;
blocks{1}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7];
blocks{1}.msec=[500 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 500];
blocks{1}.slicing=100
blocks{1}.repetitions=1
blocks{1}.name='images 1';
.
.
.
blocks{n}.randomization=0;
blocks{n}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7];
blocks{n}.msec=[500 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 500];
blocks{n}.slicing=100;
blocks{n}.repetitions=1;
blocks{n}.name='images N';
````


Alternatively, as this protocolfile.m is a MATLAB script, you can use more flexible descriptions by using some mathematics formulas and MATLAB functions.


**Example 2**

````MATLAB
blocks{1}.randomization=0;
blocks{1}.sequence=201;
blocks{1}.msec=16000;
blocks{1}.slicing=100;
blocks{1}.repetitions=1;
blocks{1}.name='The First Fixation';

block_counter=1; n_each=20;
for ii=1:1:100/n_each
  block_counter=block_counter+1;
  stim_array=n_each*(ii-1)+1:n_each*ii;
  stim_array=[stim_array;stim_array+100;stim_array;stim_array+100];
  stim_array=stim_array(:)';

  blocks{block_counter}.randomization=0;
  blocks{block_counter}.sequence=Pad2Array(stim_array,201,0);
  blocks{block_counter}.msec=repmat([200,100],1,numel(stim_array));
  blocks{block_counter}.slicing=100;
  blocks{block_counter}.repetitions=3;
  blocks{block_counter}.name=sprintf('Voronoi Textures %02d',ii);

  block_counter=block_counter+1;
  blocks{block_counter}.randomization=0;
  blocks{block_counter}.sequence=201;
  blocks{block_counter}.msec=6000;
  blocks{block_counter}.slicing=100;
  blocks{block_counter}.repetitions=1;
  blocks{block_counter}.name='Fixation Rest';
end

% replace the final fixation rest as below.
blocks{block_counter}.randomization=0;
blocks{block_counter}.sequence=201;
blocks{block_counter}.msec=16000;
blocks{block_counter}.slicing=100;
blocks{block_counter}.repetitions=1;
blocks{block_counter}.name='The Final Fixation';
````
