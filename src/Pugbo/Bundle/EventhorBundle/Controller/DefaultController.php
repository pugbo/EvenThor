<?php

namespace Pugbo\Bundle\EventhorBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction($name)
    {
        return $this->render('PugboEventhorBundle:Default:index.html.twig', array('name' => $name));
    }
}
