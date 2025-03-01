DELIMITER $$

CREATE PROCEDURE CloneTableBatched(
    IN source_table VARCHAR(64),
    IN destination_table VARCHAR(64),
    IN batch_size INT
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE last_id BIGINT DEFAULT 0;
    DECLARE max_id BIGINT;

    -- Get the maximum ID from the source table
    SET @query = CONCAT('SELECT MAX(id) INTO @max_id FROM ', source_table);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Start loop for batch insertion
    REPEAT
        -- Insert data in batches
        SET @query = CONCAT(
            'INSERT INTO ', destination_table, ' SELECT * FROM ', source_table,
            ' WHERE id > ', last_id, ' ORDER BY id LIMIT ', batch_size
        );
        PREPARE stmt FROM @query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        -- Update last_id
        SET @query = CONCAT('SELECT MAX(id) INTO @last_id FROM ', destination_table);
        PREPARE stmt FROM @query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        -- Check if all rows are copied
        IF last_id >= @max_id THEN
            SET done = 1;
        END IF;

    UNTIL done END REPEAT;
END$$

DELIMITER ;
