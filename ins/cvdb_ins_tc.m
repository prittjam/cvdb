function [auto_id] = cvdb_ins_tc(conn, ...
                                 cfg, u, type, us_time_elapsed, ...
                                 pair_hash, tc_cfg_hash, ...
                                 tags)
    
    connh = conn.Handle;

    [tc_cfg_exist] = cvdb_sel_tc_cfg_exist(conn, tc_cfg, tc_cfg_hash);
    
    if (~tc_cfg_exist)
        cvdb_ins_tc_cfg(conn, tc_cfg, tc_cfg_hash);        
    end
    
    stm = connh.prepareStatement(['INSERT INTO tc ' ...
                        '(cfg_id, pair_id, data, count, type, us_time_elapsed) ' ...
                        'VALUES(UNHEX(?),UNHEX(?),?,?,?,?)'], ...
                                 java.sql.Statement.RETURN_GENERATED_KEYS);
    
    stm.setString(1, tc_cfg_hash);
    stm.setString(2, pair_hash);
    stm.setObject(3, typecast(u(:), 'uint8'));
    stm.setInt(4, size(u,2));
    stm.setString(5, type);
    stm.setInt(6, us_time_elapsed);

    stm.execute();
    rs = stm.getGeneratedKeys();
    rs.next();
    auto_id = rs.getInt(1);
    
    close(stm);