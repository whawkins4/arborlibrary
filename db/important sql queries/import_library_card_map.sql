CREATE TABLE library_card_map
(
  first character varying(500),
   last character varying(500),
   grade character varying(500),
 
  new character varying(500),
  old character varying(500) 
);


COPY library_card_map from '/Users/willhawkins/arborlibrary/db/patron_data/library_cards_old_and_new.csv' with csv;

delete from library_card_map where first = 'First Name';