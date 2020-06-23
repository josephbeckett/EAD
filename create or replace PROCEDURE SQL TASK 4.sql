create or replace PROCEDURE proc_room_charge_update (roomtype Varchar2, roomcharge Number)
IS
    CURSOR Hotel_Cursor IS
        SELECT HOTEL_ID,
                CUST_NAME,
                ROOMTYPE,
                DEPOSIT_PAID,
                ROOM_CHARGE
        FROM Hotel 
        FOR UPDATE;

    Hotel_Record Hotel%ROWTYPE;

BEGIN
    IF NOT (Hotel_Cursor%ISOPEN) THEN
        OPEN Hotel_Cursor;
    END IF;

        LOOP
            FETCH Hotel_Cursor INTO hotel_record;

            EXIT WHEN Hotel_Cursor%NOTFOUND;

            IF hotel_record.room_charge < roomcharge AND hotel_record.roomtype = roomtype THEN
                UPDATE Hotel set room_charge = roomcharge WHERE CURRENT OF Hotel_Cursor;
            END IF;
        END LOOP;

        IF hotel_Cursor%ISOPEN THEN
            CLOSE Hotel_Cursor;
        END IF;

        END;