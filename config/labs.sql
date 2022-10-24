INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('battery', 'Batterie rechargeable', 1, 0, 1),
('gaz', 'Gaz', 1, 0, 1),
('meth_bag', 'Pochon de meth', 1, 0, 1),
('methylamine', 'Methylamine', 1, 0, 0),
('water_canister', 'Bidon d\'eau', 1, 0, 1),
('weed_bag', 'Pochon de Weed', 1, 0, 1),
('weed_fan', 'Ventilateur', 1, 0, 1),
('weed_light', 'Lampe pour Weed', 1, 0, 1),
('weed_plant', 'Plante de weed', 1, 0, 1),
('weed_pot', 'Pot de weed', 1, 0, 1);

CREATE TABLE `laboratory` (
  `id` int(11) NOT NULL,
  `metadata` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `chest` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `laboratory`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `laboratory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
COMMIT;