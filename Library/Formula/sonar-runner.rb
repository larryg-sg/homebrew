require 'formula'

class SonarRunner < Formula
  homepage 'http://docs.codehaus.org/display/SONAR/Installing+and+Configuring+SonarQube+Runner'
  url 'http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.3/sonar-runner-dist-2.3.zip'
  sha1 '802312f74f55d671f6ae08f21e965fd66ca1853e'

  def install
    # Remove windows files
    rm_rf Dir['bin/*.bat']
    libexec.install Dir['*']
    bin.write_exec_script libexec/'bin/sonar-runner'
  end

  def caveats; <<-EOS.undent
      If this is your first install, you should adjust its default configuration:
        #{libexec}/conf/sonar-runner.properties

      after that you should also add a new enviroment variable:
        SONAR_RUNNER_HOME=#{libexec}
      EOS
  end

  test do
    system "#{bin}/sonar-runner", "-h"
  end
end
