<?php

function trimInput($text, $maxChar = 0){
    if ($maxChar == 0) return $text;

    if (strlen($text) <= $maxChar) return $text;

    return substr($text,0, $maxChar);
}
?>
