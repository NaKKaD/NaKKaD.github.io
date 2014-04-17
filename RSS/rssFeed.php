<?php

if (PHP_VERSION >= 5) {
    // Emulate the old xslt library functions
    function xslt_create() {
        return new XsltProcessor();
    }

    function xslt_process($xsltproc, 
                          $xml_arg, 
                          $xsl_arg, 
                          $xslcontainer = null, 
                          $args = null, 
                          $params = null) {
        // Start with preparing the arguments
        $xml_arg = str_replace('arg:', '', $xml_arg);
        $xsl_arg = str_replace('arg:', '', $xsl_arg);

        // Create instances of the DomDocument class
        $xml = new DomDocument;
        $xsl = new DomDocument;

        // Load the xml document and the xsl template
        $xml->loadXML($args[$xml_arg]);
        $xsl->loadXML($args[$xsl_arg]);

        // Load the xsl template
        $xsltproc->importStyleSheet($xsl);

        // Set parameters when defined
        if ($params) {
            foreach ($params as $param => $value) {
                $xsltproc->setParameter("", $param, $value);
            }
        }

        // Start the transformation
        $processed = $xsltproc->transformToXML($xml);

        // Put the result in a file when specified
        if ($xslcontainer) {
            return @file_put_contents($xslcontainer, $processed);
        } else {
            return $processed;
        }

    }

    function xslt_free($xsltproc) {
        unset($xsltproc);
    }
}

$browser = $_SERVER['HTTP_USER_AGENT'];

if(strpos($browser, 'Chrome')) {
	$arguments = array(
    '/_xml' => file_get_contents("rss.xml"),
    '/_xsl' => file_get_contents("world.xsl")
	);
} else if(strpos($browser, 'Firefox')) {
	$arguments = array(
    '/_xml' => file_get_contents("rss.xml"),
    '/_xsl' => file_get_contents("technology.xsl")
	);
} else if(strpos($browser, 'Trident')) {
	$arguments = array(
    '/_xml' => file_get_contents("rss.xml"),
    '/_xsl' => file_get_contents("politics.xsl")
	);
} else if(strpos($browser, 'WindowsPhone') || strpos($browser, 'Android') || strpos($browser, 'iPhone')) {
	$arguments = array(
    '/_xml' => file_get_contents("rss.xml"),
    '/_xsl' => file_get_contents("all.xsl")
	);
}


$xsltproc = xslt_create();
$html = xslt_process(
    $xsltproc, 
    'arg:/_xml', 
    'arg:/_xsl', 
    null, 
    $arguments
);

xslt_free($xsltproc);
print $html;

?>