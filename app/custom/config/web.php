<?php

$configDir = __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'models' .
    DIRECTORY_SEPARATOR . 'settings' . DIRECTORY_SEPARATOR;
require_once($configDir . 'JsonConfigTrait.php');
require_once($configDir . 'AntragsgruenApp.php');

if (YII_ENV == 'test') {
    $configFile = __DIR__ . DIRECTORY_SEPARATOR . 'config_tests.json';
} elseif (isset($_SERVER['ANTRAGSGRUEN_CONFIG'])) {
    $configFile = $_SERVER['ANTRAGSGRUEN_CONFIG'];
} else {
    $configFile = __DIR__ . DIRECTORY_SEPARATOR . 'config.json';
}
if (file_exists($configFile)) {
    $config = file_get_contents($configFile);
} else {
    $config = '';
}
try {
    $params = new \app\models\settings\AntragsgruenApp($config);
} catch (\Exception $e) {
    die('Could not load configuration; probably due to a syntax error in config/config.json?');
}

if (YII_DEBUG === false) {
    $params->dbConnection['enableSchemaCache']   = true;
    $params->dbConnection['schemaCacheDuration'] = 3600;
    $params->dbConnection['schemaCache']         = 'cache';
}

$host = getenv('ANTRAGSGRUEN_MYSQL_HOST');
$db =  getenv('ANTRAGSGRUEN_MYSQL_DB');
$user =  getenv('ANTRAGSGRUEN_MYSQL_USER');
$password = getenv('ANTRAGSGRUEN_MYSQL_PASSWORD');
if (isset($host)) {
   $params->dbConnection['dsn'] = "mysql:host=$host;dbname=$db";
   $params->dbConnection['username'] = $user;
   $params->dbConnection['password'] = $password;
}

$smtpHost = getenv('ANTRAGSGRUEN_SMTP_HOST');
$smtpPort = getenv('ANTRAGSGRUEN_SMTP_PORT');
$smtpAuthType = getenv('ANTRAGSGRUEN_SMTP_AUTH_TYPE');
$smtpEncryption = getenv('ANTRAGSGRUEN_SMTP_ENCRYPTION');
$smtpUser = getenv('ANTRAGSGRUEN_SMTP_USER');
$smtpPassword = getenv('ANTRAGSGRUEN_SMTP_PASSWORD');

if (isset($smtpHost)) {
    $params->mailService['transport'] = 'smtp';
    $params->mailService['host'] = $smtpHost;
    $params->mailService['port'] = $smtpPort;
    $params->mailService['authType'] = $smtpAuthType;
    $params->mailService['encryption'] = $smtpEncryption;
    $params->mailService['username'] = $smtpUser;
    $params->mailService['password'] = $smtpPassword;
}

$mailFromName = getenv('ANTRAGSGRUEN_MAIL_FROM_NAME');
if (isset($mailFromName)) {
    $params->mailFromName = $mailFromName;
}

$mailFromEmail = getenv('ANTRAGSGRUEN_MAIL_FROM_EMAIL');
if (isset($mailFromEmail)) {
    $params->mailFromEmail = $mailFromEmail;
}

$multisiteMode = getenv('ANTRAGSGRUEN_MULTISITE_MODE');
if (isset($multisiteMode)) {
    $params->multisiteMode = $multisiteMode;
}

$siteSubdomain = getenv('ANTRAGSGRUEN_SITE_SUBDOMAIN');
if (isset($siteSubdomain)) {
    $params->siteSubdomain = $siteSubdomain;
}

$domain = getenv('ANTRAGSGRUEN_DOMAIN');
if (isset($domain)) {
    $params->domainPlain = $domain;
}

$domainSubdomain = getenv('ANTRAGSGRUEN_DOMAIN_SUBDOMAIN');
if (isset($domainSubdomain)) {
    $params->domainSubdomain = $domainSubdomain;
}

$common = require(__DIR__ . DIRECTORY_SEPARATOR . 'common.php');

$csrfCookie = [
    'httpOnly' => true,
    'sameSite' => PHP_VERSION_ID >= 70300 ? yii\web\Cookie::SAME_SITE_LAX : null
];
if ((isset($_SERVER['REQUEST_SCHEME']) && strtolower($_SERVER['REQUEST_SCHEME']) === 'https') || (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on')) {
    $csrfCookie['secure'] = true;
}

$config = yii\helpers\ArrayHelper::merge(
    $common,
    [
        'id'         => 'basic',
        'components' => [
            'errorHandler'         => [
                //'errorAction' => 'manager/error',
            ],
            'user'                 => [
                'identityClass'   => 'app\models\db\User',
                'enableAutoLogin' => true,
            ],
            'authClientCollection' => [
                'class'   => 'yii\authclient\Collection',
                'clients' => $params->authClientCollection,
            ],
            'request'              => [
                'cookieValidationKey' => $params->randomSeed,
                'csrfCookie'          => $csrfCookie,

                // Trust proxies from reverse proxies on local networks - necessary for getIsSecureConnection()
                'trustedHosts' => [
                    '10.0.0.0/8',
                    '172.16.0.0/12',
                    '192.168.0.0/16',
                ],
            ],
            'assetManager'         => [
                'appendTimestamp' => false,
            ],
        ],
    ]
);
if ($params->cookieDomain) {
    $config['components']['session'] = [
        'cookieParams' => [
            'httponly' => true,
            'domain'   => $params->cookieDomain,
            'sameSite' => PHP_VERSION_ID >= 70300 ? yii\web\Cookie::SAME_SITE_LAX : null,
        ]
    ];
} elseif ($params->domainPlain) {
    $config['components']['session'] = [
        'cookieParams' => [
            'httponly' => true,
            'domain'   => '.' . parse_url($params->domainPlain, PHP_URL_HOST),
            'sameSite' => PHP_VERSION_ID >= 70300 ? yii\web\Cookie::SAME_SITE_LAX : null,
        ]
    ];
}

if (YII_ENV_DEV && file_exists($configFile) && strpos($_SERVER['HTTP_USER_AGENT'], 'pa11y') === false) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][]      = 'debug';
    $config['modules']['debug'] = [
        'class'      => 'yii\debug\Module',
        'allowedIPs' => ['*'],
    ];
}

return $config;
