<?php
header('Content-Type: text/plain');

$_SERVER['HTTP_HOST'] = getenv('DOMAIN_NAME') ?: 'localhost';

define('WP_USE_THEMES', false);
require_once dirname(__FILE__) . '/wp-load.php';

if (!function_exists('get_option')) {
    echo "# ERROR: WordPress not fully loaded\n";
    exit(1);
}

// Output total users
$total_users = count_users()['total_users'];
echo "# HELP wp_user_count Total number of registered WordPress users\n";
echo "# TYPE wp_user_count gauge\n";
echo "wp_user_count $total_users\n";

// Output post count
$post_count = wp_count_posts()->publish;
echo "# HELP wp_post_count Total number of published posts\n";
echo "# TYPE wp_post_count gauge\n";
echo "wp_post_count $post_count\n";

// Output approved comment count
$comment_count = wp_count_comments()->approved;
echo "# HELP wp_comment_count Total number of approved comments\n";
echo "# TYPE wp_comment_count gauge\n";
echo "wp_comment_count $comment_count\n";

// Output active plugin count
$plugins = get_option('active_plugins');
$active_plugins = is_array($plugins) ? count($plugins) : 0;
echo "# HELP wp_active_plugin_count Total number of active plugins\n";
echo "# TYPE wp_active_plugin_count gauge\n";
echo "wp_active_plugin_count $active_plugins\n";

// Output current theme name as label
$current_theme = wp_get_theme();
echo "# HELP wp_theme_name Current active theme name\n";
echo "# TYPE wp_theme_name gauge\n";
echo 'wp_theme_name{theme="' . $current_theme->get('Name') . '"} 1' . "\n";

