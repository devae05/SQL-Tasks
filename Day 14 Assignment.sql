create table products(
product_id int primary key auto_increment,
name varchar(100),
price decimal(10,2),
stock_quantity int,
status varchar(20) default 'available'
);

create table inventory_audit(
audit_id int primary key auto_increment,
product_id int,
action_type varchar(50),
old_value varchar(100),
new_value varchar(100),
changed_at timestamp default current_timestamp
);


delimiter //

create trigger trg_prevent_negative_stock
before update on products
for each row
begin
if new.stock_quantity < 0 then
signal sqlstate '45000'
set message_text='stock cannot be negative';
end if;
end //

delimiter ;


delimiter //

create trigger trg_audit_price_change
after update on products
for each row
begin
if old.price <> new.price then
insert into inventory_audit(product_id,action_type,old_value,new_value)
values(old.product_id,'price updated',old.price,new.price);
end if;
end //

delimiter ;


delimiter //

create trigger trg_auto_status
before update on products
for each row
begin
if new.stock_quantity = 0 then
set new.status='out of stock';
end if;
end //

delimiter ;


delimiter //

create trigger trg_uppercase_name
before insert on products
for each row
begin
set new.name = upper(new.name);
end //

delimiter ;


delimiter //

create trigger trg_log_new_product
after insert on products
for each row
begin
insert into inventory_audit(product_id,action_type,new_value)
values(new.product_id,'new product added',new.name);
end //

delimiter ;


delimiter //

create trigger trg_prevent_delete
before delete on products
for each row
begin
if old.stock_quantity > 0 then
signal sqlstate '45000'
set message_text='cannot delete product with stock';
end if;
end //

delimiter ;


delimiter //

create trigger trg_track_deleted
after delete on products
for each row
begin
insert into inventory_audit(product_id,action_type,old_value)
values(old.product_id,'product deleted',old.name);
end //

delimiter ;


delimiter //

create trigger trg_min_price
before insert on products
for each row
begin
if new.price < 1 then
signal sqlstate '45000'
set message_text='price must be at least 1';
end if;
end //

delimiter ;


delimiter //

create trigger trg_stock_replenish
after update on products
for each row
begin
if new.stock_quantity > old.stock_quantity then
insert into inventory_audit(product_id,action_type,old_value,new_value)
values(old.product_id,'stock increased',old.stock_quantity,new.stock_quantity);
end if;
end //

delimiter ;


delimiter //

create trigger trg_weekend_price_block
before update on products
for each row
begin
if old.price <> new.price and dayofweek(curdate()) in (1,7) then
signal sqlstate '45000'
set message_text='price update not allowed on weekends';
end if;
end //

delimiter ;
