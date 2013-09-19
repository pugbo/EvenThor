<?php

namespace Pugbo\Bundle\EventhorBundle\Controller;

use Pugbo\Bundle\EventhorBundle\Form\ProjectType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

/**
 * Class ProjectController
 * @package Pugbo\Bundle\EventhorBundle\Controller
 */
class ProjectController extends Controller
{
    /**
     * @Template()
     * @param Request $request
     * @return array
     */
    public function newAction(Request $request)
    {
        $form = $this->createForm(new ProjectType());

        if($request->getMethod() === 'POST') {
            $form->bind($request);

            if($form->isValid()) {
                $project = $form->getData();

                $objectManager = $this
                    ->getDoctrine()
                    ->getManagerForClass(get_class($project))
                ;

                $objectManager->persist($project);
                $objectManager->flush();
            }
        }

        return ['form' => $form->createView()];
    }
}
