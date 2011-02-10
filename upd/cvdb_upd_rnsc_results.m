function auto_id = cvdb_upd_rnsc_results(conn, rnsc_id, res)
    connh = conn.Handle;
    
    if ~isempty(cfg)
        rnsc_cfg_hash = cvdb_ins_rnsc_cfg(conn, cfg);
    end

    cfg_hash = rnsc_cfg_hash;
    stm = connh.prepareStatement(['UPDATE rnsc ' ...
                        'SET weights=?, errors=?, score=?, ' ...
                        'samples_drawn=?, sample_degen_count=?, ' ...
                        'us_time_elapsed=? WHERE id=?']);
    
    stm.setBytes(1, typecast(double(res.weights(:)), 'uint8'));
    stm.setBytes(2, typecast(res.errors(:), 'uint8'));
    stm.setDouble(3, res.score);
    stm.setInt(4, res.samples_drawn);
    stm.setInt(5, res.sample_degen_count);    
    stm.setInt(6, res.us_time_elapsed);    
    stm.setInt(7, rnsc_id);

    stm.execute();

    rs = stm.getGeneratedKeys();

    auto_id = 0;
    if rs.next()
        auto_id = rs.getInt(1);
        if (~isempty(tag_list))
            cvdb_ins_rnsc_taggings(conn, tag_list, auto_id);
        end
    end