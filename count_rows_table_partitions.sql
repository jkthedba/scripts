SET SERVEROUT ON SIZE 1000000
SET VERIFY OFF

DECLARE
    sql_stmt    VARCHAR2 (1024);
    row_count   NUMBER;

    CURSOR get_tab
    IS
        SELECT table_name, partition_name
          FROM dba_tab_partitions
         WHERE     table_owner = UPPER ('&&TABLE_OWNER')
               AND table_name = '&&TABLE_NAME';
BEGIN
    DBMS_OUTPUT.put_line ('Checking Record Counts for table_name');
    DBMS_OUTPUT.put_line ('Log file to numrows_part_&&TABLE_OWNER.lst ....');
    DBMS_OUTPUT.put_line ('....');

    FOR get_tab_rec IN get_tab
    LOOP
        BEGIN
            sql_stmt :=
                   'select count(*) from &&TABLE_OWNER..'
                || get_tab_rec.table_name
                || ' partition ( '
                || get_tab_rec.partition_name
                || ' )';

            EXECUTE IMMEDIATE sql_stmt INTO row_count;

            DBMS_OUTPUT.put_line (
                   'Table '
                || RPAD (
                          get_tab_rec.table_name
                       || '('
                       || get_tab_rec.partition_name
                       || ')',
                       50)
                || ' '
                || TO_CHAR (row_count)
                || ' rows.');
        EXCEPTION
            WHEN OTHERS
            THEN
                DBMS_OUTPUT.put_line (
                       'Error counting rows for table '
                    || get_tab_rec.table_name);
        END;
    END LOOP;
END;
/

SET VERIFY ON
