<?php
define('DB_NAME', getenv('WORDPRESS_DB_NAME'));
define('DB_USER', getenv('WORDPRESS_DB_USER'));
define('DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD'));
define('DB_HOST', getenv('WORDPRESS_DB_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         '+}x?X5pZFQ-q|}o2@>mMxZD3KYf1Jlpmt9+_xQ+#y>-xv@4U&nEmB+E3Ujb=M8~A');
define('SECURE_AUTH_KEY',  'Ah~i7qQ3niyA?wQ.1a`/i-IEHEqgZ:{g9k,w|UQ!J!/d%nqj~9@xcdb<9Q@0<h|V');
define('LOGGED_IN_KEY',    'uwOz,DeHOdC/a?%b1tr#xUsoY#t@eyiNfv$M#vJhGMEB|o;2?ne{Oj1w&d.%rnz_');
define('NONCE_KEY',        '2^RO{mA--_bh /+BG_{[q3aph%_<ds aSzus7%:.2_{X6:FWok}&m_8^0_fhY8g=');
define('AUTH_SALT',        'FBl+nZD9K3lqf0)+e7B)|/(c/+I6Kbo|-1Gh~L+&a>]c2l+W6kC_n>GY*#jdvz;0');
define('SECURE_AUTH_SALT', '_8,*r9BS=J%5anUbkYQ;2E8w$L.Y0}m]|@AfPPY5A8CoGWMokfiqIuB nSS0`+ta');
define('LOGGED_IN_SALT',   '/+_|e?||O};1-MD4`oDK)gW|tbte&2iXC./)2eX$h{+Y9@Ipmj1ddwmz MKXM?,,');
define('NONCE_SALT',       'TEWJe>1BT@h`ae.)~V)T!scHrPnP-(~~;,aBa%%v/t%J_S]y.bT8|P$(Fu<x(?56');

$table_prefix = 'wp_';

define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);

if (!defined('ABSPATH'))
{
	define('ABSPATH', dirname(__FILE__) . '/');
}

require_once ABSPATH . 'wp-settings.php';
