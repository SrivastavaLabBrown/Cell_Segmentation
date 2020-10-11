## Cell_Segmentation
Cell_Seg: 
Matlab tool for cell microscopy image segmentation 

G.Zhu

5-11-2015 / updated 10-11-2020

I present you a segmentation tool that help with identification of brain cells for morphological studies of WT mice neuron. Primary objective of the tool is to assist in identification of neuron size in health and cognitive impairment WT mice. Application can be applied in other cell as well for morpholigical studies and basic cell counting.

## The primary steps of Cell_Seg includes: 
1) Enhancement*
2) Segmentation
3) Thresholding with histogram
4) Construct binary threshold map based on image histogram
5) Clustering of neuron
6) Filtering small neurons
7) Segmentation with color based on neuron morphology (displayed with alpha map)

The segmented neurons will be assigned into different color based on the neuron size. Thresholding was selected based on histogram of the raw input image. Smaller neurons were ignored to better study mature neuron morphology from the cluster. 

## Source: 
http://atlas.brain-map.org/atlas?atlas=1&plate=100960324#atlas=1&plate=100960324
