class Typo3::Backend::BackendController < ApplicationController

layout 'backend'

def index
  @workspaceName = 'user-skeller1'
end

end

#	public function indexAction() {
#		$workspaceName = 'user-' . $this->securityContext->getAccount()->getAccountIdentifier();
#		$contentContext = $this->objectManager->create('F3\TYPO3\Domain\Service\ContentContext', $workspaceName);

#		$this->view->assign('contentContext', $contentContext);
#
#		$version = $this->packageManager->getPackage('TYPO3')->getPackageMetaData()->getVersion();
#		$this->view->assign('version', $version);
#	}