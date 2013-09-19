<?php

namespace Pugbo\Bundle\EventhorBundle\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

/**
 * Class ProjectControllerTest
 * @package Pugbo\Bundle\EventhorBundle\Tests\Controller
 */
class ProjectControllerTest extends WebTestCase
{
    public function testNewPageSimple()
    {
        $client = static::createClient();

        $crawler = $client->request('GET', '/projects/new');

        $this->assertEquals(200, $client->getResponse()->getStatusCode(), 'Status code should be 200');
        $this->assertTrue($crawler->filter('html:contains("EvenThor")')->count() > 0);
    }

    public function testNewProject()
    {
        $client = static::createClient();

        $crawler = $client->request('GET', '/projects/new');
        $buttonCrawlerNode = $crawler->selectButton('submit');
        $form = $buttonCrawlerNode->form();

        $form['pugbo_bundle_eventhorbundle_projecttype[title]'] = 'Some cool title';
        $form['pugbo_bundle_eventhorbundle_projecttype[description]'] = 'Some cool description';

        $response = $client->submit($form);

        $this->assertEquals(200, $client->getResponse()->getStatusCode(), 'Status code should be 200');
    }
}
