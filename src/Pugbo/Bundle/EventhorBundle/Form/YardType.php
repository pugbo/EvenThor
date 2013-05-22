<?php

namespace Pugbo\Bundle\EventhorBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class YardType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('title')
            ->add('description', 'textarea')
            ->add('open', null, ['required' => false])
        ;
    }

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Pugbo\Bundle\EventhorBundle\Entity\Yard'
        ));
    }

    public function getName()
    {
        return 'pugbo_bundle_eventhorbundle_yardtype';
    }
}
