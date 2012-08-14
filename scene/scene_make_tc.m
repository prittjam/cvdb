function m = scene_make_tc(dr1,dr2,cfg)
global conn;
[m,n] = size(dr1.sifts);
pts1 = struct('desc',num2cell(dr1.sifts',2),...
              'x',num2cell(dr1.geom(1,:)',2),...
              'y',num2cell(dr1.geom(2,:)',2),...
              'a11',num2cell(dr1.geom(3,:)',2),...
              'a12',num2cell(dr1.geom(4,:)',2),...
              'a21',num2cell(dr1.geom(5,:)',2),...
              'a22',num2cell(dr1.geom(6,:)',2),...
              'id',num2cell(dr1.id',2));

[m,n] = size(dr2.sifts);

pts2 = struct('desc',num2cell(dr2.sifts',2),...
              'x',num2cell(dr2.geom(1,:)',2),...
              'y',num2cell(dr2.geom(2,:)',2),...
              'a11',num2cell(dr2.geom(3,:)',2),...
              'a12',num2cell(dr2.geom(4,:)',2),...
              'a21',num2cell(dr2.geom(5,:)',2),...
              'a22',num2cell(dr2.geom(6,:)',2),...
              'id',num2cell(dr2.id',2));

[pc m] = wbs_match_descriptions(pts1, pts2, wbs_default_cfg());