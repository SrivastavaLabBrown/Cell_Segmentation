% Use intensity thresholding to identify cells in high-resolution picture
% of brain slice. Remove unusally small clusters. 
% Goal: Intensity thresholding based segmentation
%       Color the clusters based on size

% read input image
img = imread('original.jpg');
figure(1), clf
imshow(img)

% Select subsection of the mice brain
img = squeeze(mean( img(1170:2430, 2280:3810,:) ,3));

% Zoom into the subsection
imagesc(img), axis image
colormap gray

% Threshold identification using histogram
figure(2), clf
hist(img(:), 500)

thresh = 215;

% Create binary threshold map using pre-defined threshold value
threshmap = img < thresh;

% Extract cluster information from the input image
units = bwconncomp( threshmap);

% Show processed image
% Overlapping cell could be caused by high thresholding
% Create zoom in function to check for overlapping neurons
imagesc(img), hold on
contour(threshmap, 1, 'r')
axis image
colormap gray
zoom on

% Remove small clusters/individual neurons
unitsizes = cellfun(@length, units.PixelIdxList);
figure(3), clf
hist(unitsizes, 900)
set(gca, 'xlim', [0 260])
xlabel('Unit size is (pixels)'), ylabel('Count')

% Select pixel threshold
pixthresh = 8;

% Reconstruction of threshold map
% For loop filtering out small neurons
threshmapFil = false(size(threshmap));
for ui = 1:units.NumObjects
    % ignore if unit is smaller than pixel threshold
    % set it to true
    if unitsizes(ui)<pixthresh
        continue;
    end
    % Not running if above is not true
    threshmapFil(units.PixelIdxList{ui})=1;
end

% Append newly filtered threshold map on top of previous segmented map
% Same image different color
figure(4)
% Use b->blue color and make the line thicker with linew(2)
contour(threshmapFil,1, 'b','linew',2)

% Color clustering based on size
size_map = nan(size(img));
for ui=1:units.NumObjects
    size_map(units.PixelIdxList{ui}) = log(unitsizes(ui));
end

% create transparency alpha map
alphamap = ones(size(img));
alphamap( ~isfinite(size_map)) = 0;

% Display with alpha map
figure(5), clf
imagesc(size_map, 'AlphaData', alphamap)
set(gca, 'clim',[0 7])