function [] = read_img()
    try
        img = readim(filecontent);
    catch
        if exist('/tmp','dir') == 7
            tmpurl = ['/tmp/tmpimpng' cid];
        else
            tmpurl = ['tmpimpng' cid];
        end
        fid = fopen(tmpurl,'w');
        fwrite(fid,filecontent);
        fclose(fid);
        img = imread(tmpurl);
        delete(tmpurl);                    
    end
end
