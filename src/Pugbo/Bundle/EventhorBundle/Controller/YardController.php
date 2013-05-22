<?php

namespace Pugbo\Bundle\EventhorBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

/**
 * Class YardController
 * @package Pugbo\Bundle\EventhorBundle\Controller
 */
class YardController extends Controller
{
    /**
     * @Template()
     */
    public function newAction()
    {
        return[];
    }
}
