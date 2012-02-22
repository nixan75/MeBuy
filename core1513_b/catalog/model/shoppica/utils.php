<?php

class TBRegistry
{
    private static $instance;
    private $data = array();
    private $model;

    private function __construct(){}

    public static function getInstance()
    {
        if (!isset(self::$instance)) {
            $className = __CLASS__;
            self::$instance = new $className;
        }

        return self::$instance;
    }

    public function setModel($model)
    {
        $this->model = $model;
    }

    public function getModel()
    {
        return $this->model;
    }

    public function __set($key, $value)
    {
        $this->set($key, $value);
    }

    public function __get($key)
    {
        return $this->get($key);
    }

    public function __isset($key)
    {
        return $this->has($key);
    }

    public function get($key)
    {
        return (isset($this->data[$key]) ? $this->data[$key] : null);
    }

    public function set($key, $value)
    {
        $this->data[$key] = $value;
    }

    public function has($key)
    {
        return isset($this->data[$key]);
    }
}

class Browser
{
    public static function detect()
    {
        $userAgent = strtolower($_SERVER['HTTP_USER_AGENT']);

        if (preg_match('/opera/', $userAgent)) {
            $name = 'opera';
        }
        elseif (preg_match('/webkit/', $userAgent)) {
            $name = 'safari';
        }
        elseif (preg_match('/msie/', $userAgent)) {
            $name = 'msie';
        }
        elseif (preg_match('/mozilla/', $userAgent) && !preg_match('/compatible/', $userAgent)) {
            $name = 'mozilla';
        }
        else {
            $name = 'unrecognized';
        }

        // What version?
        if (preg_match('/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/', $userAgent, $matches)) {
            $version = $matches[1];
        }
        else {
            $version = 'unknown';
        }

        // Running on what platform?
        if (preg_match('/linux/', $userAgent)) {
            $platform = 'linux';
        }
        elseif (preg_match('/macintosh|mac os x/', $userAgent)) {
            $platform = 'mac';
        }
        elseif (preg_match('/windows|win32/', $userAgent)) {
            $platform = 'windows';
        }
        else {
            $platform = 'unrecognized';
        }

        return array(
            'name'      => $name,
            'version'   => $version,
            'platform'  => $platform,
            'userAgent' => $userAgent
        );
    }
}

function glue_url($parsed)
{
    if (!is_array($parsed)) {
        return false;
    }

    $uri = isset($parsed['scheme']) ? $parsed['scheme'].':'.((strtolower($parsed['scheme']) == 'mailto') ? '' : '//') : '';
    $uri .= isset($parsed['user']) ? $parsed['user'].(isset($parsed['pass']) ? ':'.$parsed['pass'] : '').'@' : '';
    $uri .= isset($parsed['host']) ? $parsed['host'] : '';
    $uri .= isset($parsed['port']) ? ':'.$parsed['port'] : '';

    if (isset($parsed['path'])) {
        $uri .= (substr($parsed['path'], 0, 1) == '/') ?
            $parsed['path'] : ((!empty($uri) ? '/' : '' ) . $parsed['path']);
    }

    $uri .= isset($parsed['query']) ? '?'.$parsed['query'] : '';
    $uri .= isset($parsed['fragment']) ? '#'.$parsed['fragment'] : '';

    return $uri;
}

function modifyBase($base, $url)
{
    $base_parsed = parse_url($base);
    $base_host = $base_parsed['host'];

    $url_parsed = parse_url($base_parsed['scheme'] . '://' . $url);
    $url_host = $url_parsed['host'];

    if (stripos($url_host, $base_host) !== 0) {
        if (substr($url_host, 0, 4) == 'www.') {
            $base_host = 'www.' . $base_host;
        } else
        if (substr($base_host, 0, 4) == 'www.') {
            $base_host = substr($base_host, 4);
        }
    }
    $base_parsed['host'] = $base_host;

    return glue_url($base_parsed);
}

function isHTTPS()
{
    return isset($_SERVER['HTTPS']) && ($_SERVER['HTTPS'] == 'on' || $_SERVER['HTTPS'] == 1);
}

function s_format($price, $currency_obj = null)
{
    static $obj = null;

    if (null !== $currency_obj) {
        $obj = $currency_obj;
    }

    if ($obj == null || null == $price) {

        return $price;
    }

    $symbol_left = trim($obj->getSymbolLeft());
    $symbol_right = trim($obj->getSymbolRight());

    if(function_exists('mb_substr')) {
        if (!empty($symbol_left)) {
            $price = mb_substr($price, 0, mb_strpos($price, $symbol_left, null, 'UTF-8'), 'UTF-8') . '<span class="s_currency s_before">' . $symbol_left . '</span>' . mb_substr($price, mb_strpos($price, $symbol_left, null, 'UTF-8') + mb_strlen($symbol_left, 'UTF-8'), mb_strlen($price, 'UTF-8'), 'UTF-8');
        }

        if (!empty($symbol_right)) {
            $price = mb_substr($price, 0, mb_strrpos($price, $symbol_right, null, 'UTF-8'), 'UTF-8') . '<span class="s_currency s_after">' . $symbol_right . '</span>' . mb_substr($price, mb_strrpos($price, $symbol_right, null, 'UTF-8') + mb_strlen($symbol_right, 'UTF-8'), mb_strlen($price, 'UTF-8'), 'UTF-8');
        }
    } else
    if (function_exists('utf8_substr')) {
        if (!empty($symbol_left)) {
            $price = utf8_substr($price, 0, utf8_strpos($price, $symbol_left)) . '<span class="s_currency s_before">' . $symbol_left . '</span>' . utf8_substr($price, utf8_strpos($price, $symbol_left) + utf8_strlen($symbol_left), utf8_strlen($price));
        }

        if (!empty($symbol_right)) {
            $price = utf8_substr($price, 0, utf8_strrpos($price, $symbol_right)) . '<span class="s_currency s_after">' . $symbol_right . '</span>' . utf8_substr($price, utf8_strrpos($price, $symbol_right) + utf8_strlen($symbol_right), utf8_strlen($price));
        }
    } else {
        if (!empty($symbol_left)) {
            $price = substr_replace($price, '<span class="s_currency s_before">' . $symbol_left . '</span>', strpos($price, $symbol_left), strlen($symbol_left));
        }

        if (!empty($symbol_right)) {
            $price = substr_replace($price, '<span class="s_currency s_after">' . $symbol_right . '</span>', strrpos($price, $symbol_right), strlen($symbol_right));
        }
    }

    return $price;
}