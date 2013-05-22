<?php

namespace Pugbo\Bundle\EventhorBundle\Controller;

use Pugbo\Bundle\EventhorBundle\Form\YardType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

/**
 * Class YardController
 * @package Pugbo\Bundle\EventhorBundle\Controller
 */
class YardController extends Controller
{
    /**
     * @Template()
     * @param Request $request
     * @return array
     */
    public function newAction(Request $request)
    {
        $form = $this->createForm(new YardType());

        if($request->getMethod() === 'POST') {
            $form->bind($request);

            if($form->isValid()) {
                $yard = $form->getData();

                $objectManager = $this
                    ->getDoctrine()
                    ->getManagerForClass(get_class($yard))
                ;

                $objectManager->persist($yard);
                $objectManager->flush();
            }
        }

        return ['form' => $form->createView()];
    }
}
