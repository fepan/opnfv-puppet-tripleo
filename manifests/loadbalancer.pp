# Copyright 2014 Red Hat, Inc.
# All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# == Class: tripleo::loadbalancer
#
# Configure an HAProxy/keepalived loadbalancer for TripleO.
#
# === Parameters:
#
# [*manage_vip*]
#  Whether to configure keepalived to manage the VIPs or not.
#  Defaults to true
#
# [*haproxy_service_manage*]
#  Will be passed as value for service_manage to HAProxy module.
#  Defaults to true
#
# [*haproxy_global_maxconn*]
#  The value to use as maxconn in the HAProxy global config section.
#  Defaults to 20480
#
# [*haproxy_default_maxconn*]
#  The value to use as maxconn in the HAProxy default config section.
#  Defaults to 4096
#
# [*haproxy_default_timeout*]
#  The value to use as timeout in the HAProxy default config section.
#  Defaults to [ 'http-request 10s', 'queue 1m', 'connect 10s', 'client 1m', 'server 1m', 'check 10s' ]
#
# [*haproxy_listen_bind_param*]
#  A list of params to be added to the HAProxy listener bind directive. By
#  default the 'transparent' param is added but it should be cleared if
#  one of the *_virtual_ip addresses is a wildcard, eg. 0.0.0.0
#  Defaults to [ 'transparent' ]
#
# [*haproxy_member_options*]
#  The default options to use for the HAProxy balancer members.
#  Defaults to [ 'check', 'inter 2000', 'rise 2', 'fall 5' ]
#
# [*haproxy_log_address*]
#  The IPv4, IPv6 or filesystem socket path of the syslog server.
#  Defaults to '/dev/log'
#
# [*controller_host*]
#  (Deprecated)Host or group of hosts to load-balance the services
#  Can be a string or an array.
#  Defaults to undef
#
# [*controller_hosts*]
#  IPs of host or group of hosts to load-balance the services
#  Can be a string or an array.
#  Defaults to undef
#
# [*controller_hosts_names*]
#  Names of host or group of hosts to load-balance the services
#  Can be a string or an array.
#  Defaults to undef
#
# [*controller_virtual_ip*]
#  Control IP or group of IPs to bind the pools
#  Can be a string or an array.
#  Defaults to undef
#
# [*control_virtual_interface*]
#  Interface to bind the control VIP
#  Can be a string or an array.
#  Defaults to undef
#
# [*public_virtual_interface*]
#  Interface to bind the public VIP
#  Can be a string or an array.
#  Defaults to undef
#
# [*public_virtual_ip*]
#  Public IP or group of IPs to bind the pools
#  Can be a string or an array.
#  Defaults to undef
#
# [*internal_api_virtual_ip*]
#  Virtual IP on the internal API network.
#  A string.
#  Defaults to false
#
# [*storage_virtual_ip*]
#  Virtual IP on the storage network.
#  A string.
#  Defaults to false
#
# [*storage_mgmt_virtual_ip*]
#  Virtual IP on the storage mgmt network.
#  A string.
#  Defaults to false
#
# [*haproxy_stats_user*]
#  Username for haproxy stats authentication.
#  A string.
#  Defaults to 'admin'
#
# [*haproxy_stats_password*]
#  Password for haproxy stats authentication.  When set, authentication is
#  enabled on the haproxy stats endpoint.
#  A string.
#  Defaults to undef
#
# [*service_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the public API endpoints using the specified file.
#  Any service-specific certificates take precedence over this one.
#  Defaults to undef
#
# [*ssl_cipher_suite*]
#  The default string describing the list of cipher algorithms ("cipher suite")
#  that are negotiated during the SSL/TLS handshake for all "bind" lines. This
#  value comes from the Fedora system crypto policy.
#  Defaults to '!SSLv2:kEECDH:kRSA:kEDH:kPSK:+3DES:!aNULL:!eNULL:!MD5:!EXP:!RC4:!SEED:!IDEA:!DES'
#
# [*ssl_options*]
#  String that sets the default ssl options to force on all "bind" lines.
#  Defaults to 'no-sslv3'
#
# [*keystone_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Keystone public API endpoint using the specified file.
#  Defaults to undef
#
# [*neutron_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Neutron public API endpoint using the specified file.
#  Defaults to undef
#
# [*cinder_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Cinder public API endpoint using the specified file.
#  Defaults to undef
#
# [*manila_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Manila public API endpoint using the specified file.
#  Defaults to undef
#
# [*glance_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Glance public API endpoint using the specified file.
#  Defaults to undef
#
# [*nova_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Nova public API endpoint using the specified file.
#  Defaults to undef
#
# [*ceilometer_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Ceilometer public API endpoint using the specified file.
#  Defaults to undef
#
# [*aodh_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Aodh public API endpoint using the specified file.
#
# [*sahara_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Sahara public API endpoint using the specified file.
#  Defaults to undef
#
# [*congress_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Congress public API endpoint using the specified file.
#
# [*tacker_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Tacker public API endpoint using the specified file.
#  Defaults to undef
#
# [*trove_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Trove public API endpoint using the specified file.
#  Defaults to undef
#
# [*gnocchi_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Gnocchi public API endpoint using the specified file.
#  Defaults to undef
#
# [*swift_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Swift public API endpoint using the specified file.
#  Defaults to undef
#
# [*heat_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Heat public API endpoint using the specified file.
#  Defaults to undef
#
# [*horizon_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Horizon public API endpoint using the specified file.
#  Defaults to undef
#
# [*ironic_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the Ironic public API endpoint using the specified file.
#  Defaults to undef
#
# [*haproxy_stats_certificate*]
#  Filename of an HAProxy-compatible certificate and key file
#  When set, enables SSL on the haproxy stats endpoint using the specified file.
#  Defaults to undef
#
# [*keystone_admin*]
#  (optional) Enable or not Keystone Admin API binding
#  Defaults to false
#
# [*keystone_public*]
#  (optional) Enable or not Keystone Public API binding
#  Defaults to false
#
# [*neutron*]
#  (optional) Enable or not Neutron API binding
#  Defaults to false
#
# [*cinder*]
#  (optional) Enable or not Cinder API binding
#  Defaults to false
#
# [*congress*]
#  (optional) Enable or not Congress API binding
#  Defaults to false
#
# [*manila*]
#  (optional) Enable or not Manila API binding
#  Defaults to false
#
# [*sahara*]
#  (optional) Enable or not Sahara API binding
#  defaults to false
#
# [*trove*]
#  (optional) Enable or not Trove API binding
#  defaults to false
#
# [*glance_api*]
#  (optional) Enable or not Glance API binding
#  Defaults to false
#
# [*glance_registry*]
#  (optional) Enable or not Glance registry binding
#  Defaults to false
#
# [*nova_ec2*]
#  (optional) Enable or not Nova EC2 API binding
#  Defaults to false
#
# [*nova_osapi*]
#  (optional) Enable or not Nova API binding
#  Defaults to false
#
# [*nova_metadata*]
#  (optional) Enable or not Nova metadata binding
#  Defaults to false
#
# [*nova_novncproxy*]
#  (optional) Enable or not Nova novncproxy binding
#  Defaults to false
#
# [*ceilometer*]
#  (optional) Enable or not Ceilometer API binding
#  Defaults to false
#
# [*aodh*]
#  (optional) Enable or not Aodh API binding
#  Defaults to false
#
# [*gnocchi*]
#  (optional) Enable or not Gnocchi API binding
#  Defaults to false
#
# [*swift_proxy_server*]
#  (optional) Enable or not Swift API binding
#  Defaults to false
#
# [*tacker*]
#  (optional) Enable or not Tacker API binding
#  Defaults to false
#
# [*heat_api*]
#  (optional) Enable or not Heat API binding
#  Defaults to false
#
# [*heat_cloudwatch*]
#  (optional) Enable or not Heat Cloudwatch API binding
#  Defaults to false
#
# [*heat_cfn*]
#  (optional) Enable or not Heat CFN API binding
#  Defaults to false
#
# [*horizon*]
#  (optional) Enable or not Horizon dashboard binding
#  Defaults to false
#
# [*ironic*]
#  (optional) Enable or not Ironic API binding
#  Defaults to false
#
# [*mysql*]
#  (optional) Enable or not MySQL Galera binding
#  Defaults to false
#
# [*mysql_clustercheck*]
#  (optional) Enable check via clustercheck for mysql
#  Defaults to false
#
# [*rabbitmq*]
#  (optional) Enable or not RabbitMQ binding
#  Defaults to false
#
# [*redis*]
#  (optional) Enable or not Redis binding
#  Defaults to false
#
# [*redis_password*]
#  (optional) Password for Redis authentication, eventually needed by the
#  specific monitoring we do from HAProxy for Redis
#  Defaults to undef
#
# [*midonet_api*]
#  (optional) Enable or not MidoNet API binding
#  Defaults to false
#
# [*service_ports*]
#  (optional) Hash that contains the values to override from the service ports
#  The available keys to modify the services' ports are:
#    'aodh_api_port' (Defaults to 8042)
#    'aodh_api_ssl_port' (Defaults to 13042)
#    'ceilometer_api_port' (Defaults to 8777)
#    'ceilometer_api_ssl_port' (Defaults to 13777)
#    'cinder_api_port' (Defaults to 8776)
#    'cinder_api_ssl_port' (Defaults to 13776)
#    'congress_api_port' (Defaults to 1789)
#    'congress_api_ssl_port' (Defaults to 11789)
#    'glance_api_port' (Defaults to 9292)
#    'glance_api_ssl_port' (Defaults to 13292)
#    'glance_registry_port' (Defaults to 9191)
#    'gnocchi_api_port' (Defaults to 8041)
#    'gnocchi_api_ssl_port' (Defaults to 13041)
#    'heat_api_port' (Defaults to 8004)
#    'heat_api_ssl_port' (Defaults to 13004)
#    'heat_cfn_port' (Defaults to 8000)
#    'heat_cfn_ssl_port' (Defaults to 13800)
#    'heat_cw_port' (Defaults to 8003)
#    'heat_cw_ssl_port' (Defaults to 13003)
#    'ironic_api_port' (Defaults to 6385)
#    'ironic_api_ssl_port' (Defaults to 13385)
#    'keystone_admin_api_port' (Defaults to 35357)
#    'keystone_admin_api_ssl_port' (Defaults to 13357)
#    'keystone_public_api_port' (Defaults to 5000)
#    'keystone_public_api_ssl_port' (Defaults to 13000)
#    'manila_api_port' (Defaults to 8786)
#    'manila_api_ssl_port' (Defaults to 13786)
#    'neutron_api_port' (Defaults to 9696)
#    'neutron_api_ssl_port' (Defaults to 13696)
#    'nova_api_port' (Defaults to 8774)
#    'nova_api_ssl_port' (Defaults to 13774)
#    'nova_ec2_port' (Defaults to 8773)
#    'nova_ec2_ssl_port' (Defaults to 13773)
#    'nova_metadata_port' (Defaults to 8775)
#    'nova_novnc_port' (Defaults to 6080)
#    'nova_novnc_ssl_port' (Defaults to 13080)
#    'sahara_api_port' (Defaults to 8386)
#    'sahara_api_ssl_port' (Defaults to 13386)
#    'swift_proxy_port' (Defaults to 8080)
#    'swift_proxy_ssl_port' (Defaults to 13808)
#    'tacker_api_port' (Defaults to 8888)
#    'tacker_api_ssl_port' (Defaults to 8443)
#    'trove_api_port' (Defaults to 8779)
#    'trove_api_ssl_port' (Defaults to 13779)
#  Defaults to {}
#
# [*opendaylight*]
#  (optional) Enable or not OpenDaylight binding
#  Defaults to false
#
class tripleo::loadbalancer (
  $controller_virtual_ip,
  $control_virtual_interface,
  $public_virtual_interface,
  $public_virtual_ip,
  $internal_api_virtual_ip   = false,
  $storage_virtual_ip        = false,
  $storage_mgmt_virtual_ip   = false,
  $manage_vip                = true,
  $haproxy_service_manage    = true,
  $haproxy_global_maxconn    = 20480,
  $haproxy_default_maxconn   = 4096,
  $haproxy_default_timeout   = [ 'http-request 10s', 'queue 1m', 'connect 10s', 'client 1m', 'server 1m', 'check 10s' ],
  $haproxy_listen_bind_param = [ 'transparent' ],
  $haproxy_member_options    = [ 'check', 'inter 2000', 'rise 2', 'fall 5' ],
  $haproxy_log_address       = '/dev/log',
  $haproxy_stats_user        = 'admin',
  $haproxy_stats_password    = undef,
  $controller_host           = undef,
  $controller_hosts          = undef,
  $controller_hosts_names    = undef,
  $service_certificate       = undef,
  $ssl_cipher_suite          = '!SSLv2:kEECDH:kRSA:kEDH:kPSK:+3DES:!aNULL:!eNULL:!MD5:!EXP:!RC4:!SEED:!IDEA:!DES',
  $ssl_options               = 'no-sslv3',
  $keystone_certificate      = undef,
  $neutron_certificate       = undef,
  $cinder_certificate        = undef,
  $congress_certificate      = undef,
  $sahara_certificate        = undef,
  $tacker_certificate       = undef,
  $trove_certificate         = undef,
  $manila_certificate        = undef,
  $glance_certificate        = undef,
  $nova_certificate          = undef,
  $ceilometer_certificate    = undef,
  $aodh_certificate          = undef,
  $gnocchi_certificate       = undef,
  $swift_certificate         = undef,
  $heat_certificate          = undef,
  $horizon_certificate       = undef,
  $ironic_certificate        = undef,
  $haproxy_stats_certificate = undef,
  $keystone_admin            = false,
  $keystone_public           = false,
  $neutron                   = false,
  $cinder                    = false,
  $congress                  = false,
  $sahara                    = false,
  $tacker                    = false,
  $trove                     = false,
  $manila                    = false,
  $glance_api                = false,
  $glance_registry           = false,
  $nova_ec2                  = false,
  $nova_osapi                = false,
  $nova_metadata             = false,
  $nova_novncproxy           = false,
  $ceilometer                = false,
  $aodh                      = false,
  $gnocchi                   = false,
  $swift_proxy_server        = false,
  $heat_api                  = false,
  $heat_cloudwatch           = false,
  $heat_cfn                  = false,
  $horizon                   = false,
  $ironic                    = false,
  $mysql                     = false,
  $mysql_clustercheck        = false,
  $rabbitmq                  = false,
  $redis                     = false,
  $redis_password            = undef,
  $midonet_api               = false,
  $service_ports             = {},
  $opendaylight              = false
) {
  $default_service_ports = {
    aodh_api_port => 8042,
    aodh_api_ssl_port => 13042,
    ceilometer_api_port => 8777,
    ceilometer_api_ssl_port => 13777,
    cinder_api_port => 8776,
    cinder_api_ssl_port => 13776,
    congress_api_port => 1789,
    congress_api_ssl_port => 11789,
    glance_api_port => 9292,
    glance_api_ssl_port => 13292,
    glance_registry_port => 9191,
    gnocchi_api_port => 8041,
    gnocchi_api_ssl_port => 13041,
    heat_api_port => 8004,
    heat_api_ssl_port => 13004,
    heat_cfn_port => 8000,
    heat_cfn_ssl_port => 13800,
    heat_cw_port => 8003,
    heat_cw_ssl_port => 13003,
    ironic_api_port => 6385,
    ironic_api_ssl_port => 13385,
    keystone_admin_api_port => 35357,
    keystone_admin_api_ssl_port => 13357,
    keystone_public_api_port => 5000,
    keystone_public_api_ssl_port => 13000,
    manila_api_port => 8786,
    manila_api_ssl_port => 13786,
    neutron_api_port => 9696,
    neutron_api_ssl_port => 13696,
    nova_api_port => 8774,
    nova_api_ssl_port => 13774,
    nova_ec2_port => 8773,
    nova_ec2_ssl_port => 13773,
    nova_metadata_port => 8775,
    nova_novnc_port => 6080,
    nova_novnc_ssl_port => 13080,
    sahara_api_port => 8386,
    sahara_api_ssl_port => 13386,
    swift_proxy_port => 8080,
    swift_proxy_ssl_port => 13808,
    tacker_api_port => 8888,
    tacker_api_ssl_port => 8443,
    trove_api_port => 8779,
    trove_api_ssl_port => 13779,
  }
  $ports = merge($default_service_ports, $service_ports)

  if !$controller_host and !$controller_hosts {
    fail('$controller_hosts or $controller_host (now deprecated) is a mandatory parameter')
  }
  if $controller_hosts {
    $controller_hosts_real = $controller_hosts
  } else {
    warning('$controller_host has been deprecated in favor of $controller_hosts')
    $controller_hosts_real = $controller_host
  }

  if !$controller_hosts_names {
    $controller_hosts_names_real = $controller_hosts_real
  } else {
    $controller_hosts_names_real = $controller_hosts_names
  }

  if $manage_vip {
    case $::osfamily {
      'RedHat': {
        $keepalived_name_is_process = false
        $keepalived_vrrp_script     = 'systemctl status haproxy.service'
      } # RedHat
      'Debian': {
        $keepalived_name_is_process = true
        $keepalived_vrrp_script     = undef
      }
      default: {
        warning('Please configure keepalived defaults in tripleo::loadbalancer.')
        $keepalived_name_is_process = undef
        $keepalived_vrrp_script     = undef
      }
    }

    class { '::keepalived': }
    keepalived::vrrp_script { 'haproxy':
      name_is_process => $keepalived_name_is_process,
      script          => $keepalived_vrrp_script,
    }

    # KEEPALIVE INSTANCE CONTROL
    keepalived::instance { '51':
      interface    => $control_virtual_interface,
      virtual_ips  => [join([$controller_virtual_ip, ' dev ', $control_virtual_interface])],
      state        => 'MASTER',
      track_script => ['haproxy'],
      priority     => 101,
    }

    # KEEPALIVE INSTANCE PUBLIC
    keepalived::instance { '52':
      interface    => $public_virtual_interface,
      virtual_ips  => [join([$public_virtual_ip, ' dev ', $public_virtual_interface])],
      state        => 'MASTER',
      track_script => ['haproxy'],
      priority     => 101,
    }


    if $internal_api_virtual_ip and $internal_api_virtual_ip != $control_virtual_interface {
      $internal_api_virtual_interface = interface_for_ip($internal_api_virtual_ip)
      # KEEPALIVE INTERNAL API NETWORK
      keepalived::instance { '53':
        interface    => $internal_api_virtual_interface,
        virtual_ips  => [join([$internal_api_virtual_ip, ' dev ', $internal_api_virtual_interface])],
        state        => 'MASTER',
        track_script => ['haproxy'],
        priority     => 101,
      }
    }

    if $storage_virtual_ip and $storage_virtual_ip != $control_virtual_interface {
      $storage_virtual_interface = interface_for_ip($storage_virtual_ip)
      # KEEPALIVE STORAGE NETWORK
      keepalived::instance { '54':
        interface    => $storage_virtual_interface,
        virtual_ips  => [join([$storage_virtual_ip, ' dev ', $storage_virtual_interface])],
        state        => 'MASTER',
        track_script => ['haproxy'],
        priority     => 101,
      }
    }

    if $storage_mgmt_virtual_ip and $storage_mgmt_virtual_ip != $control_virtual_interface {
      $storage_mgmt_virtual_interface = interface_for_ip($storage_mgmt_virtual_ip)
      # KEEPALIVE STORAGE MANAGEMENT NETWORK
      keepalived::instance { '55':
        interface    => $storage_mgmt_virtual_interface,
        virtual_ips  => [join([$storage_mgmt_virtual_ip, ' dev ', $storage_mgmt_virtual_interface])],
        state        => 'MASTER',
        track_script => ['haproxy'],
        priority     => 101,
      }
    }

  }

  if $keystone_certificate {
    $keystone_bind_certificate = $keystone_certificate
  } else {
    $keystone_bind_certificate = $service_certificate
  }
  if $neutron_certificate {
    $neutron_bind_certificate = $neutron_certificate
  } else {
    $neutron_bind_certificate = $service_certificate
  }
  if $cinder_certificate {
    $cinder_bind_certificate = $cinder_certificate
  } else {
    $cinder_bind_certificate = $service_certificate
  }
  if $congress_certificate {
    $congress_bind_certificate = $congress_certificate
  } else {
    $congress_bind_certificate = $service_certificate
  }
  if $sahara_certificate {
    $sahara_bind_certificate = $sahara_certificate
  } else {
    $sahara_bind_certificate = $service_certificate
  }
  if $tacker_certificate {
    $tacker_bind_certificate = $tacker_certificate
  } else {
    $tacker_bind_certificate = $service_certificate
  }
  if $trove_certificate {
    $trove_bind_certificate = $trove_certificate
  } else {
    $trove_bind_certificate = $trove_certificate
  }
  if $manila_certificate {
    $manila_bind_certificate = $manila_certificate
  } else {
    $manila_bind_certificate = $service_certificate
  }
  if $glance_certificate {
    $glance_bind_certificate = $glance_certificate
  } else {
    $glance_bind_certificate = $service_certificate
  }
  if $nova_certificate {
    $nova_bind_certificate = $nova_certificate
  } else {
    $nova_bind_certificate = $service_certificate
  }
  if $ceilometer_certificate {
    $ceilometer_bind_certificate = $ceilometer_certificate
  } else {
    $ceilometer_bind_certificate = $service_certificate
  }
  if $aodh_certificate {
    $aodh_bind_certificate = $aodh_certificate
  } else {
    $aodh_bind_certificate = $service_certificate
  }
  if $gnocchi_certificate {
    $gnocchi_bind_certificate = $gnocchi_certificate
  } else {
    $gnocchi_bind_certificate = $service_certificate
  }
  if $swift_certificate {
    $swift_bind_certificate = $swift_certificate
  } else {
    $swift_bind_certificate = $service_certificate
  }
  if $heat_certificate {
    $heat_bind_certificate = $heat_certificate
  } else {
    $heat_bind_certificate = $service_certificate
  }
  if $horizon_certificate {
    $horizon_bind_certificate = $horizon_certificate
  } else {
    $horizon_bind_certificate = $service_certificate
  }
  if $ironic_certificate {
    $ironic_bind_certificate = $ironic_certificate
  } else {
    $ironic_bind_certificate = $service_certificate
  }
  # TODO(bnemec): When we have support for SSL on private and admin endpoints,
  # have the haproxy stats endpoint use that certificate by default.
  if $haproxy_stats_certificate {
    $haproxy_stats_bind_certificate = $haproxy_stats_certificate
  }

  $keystone_public_api_vip = hiera('keystone_public_api_vip', $controller_virtual_ip)
  $keystone_admin_api_vip = hiera('keystone_admin_api_vip', $controller_virtual_ip)
  if $keystone_bind_certificate {
    $keystone_public_bind_opts = {
      "${keystone_public_api_vip}:${ports[keystone_public_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[keystone_public_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $keystone_bind_certificate]),
    }
    $keystone_admin_bind_opts = {
      "${keystone_admin_api_vip}:${ports[keystone_admin_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[keystone_admin_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $keystone_bind_certificate]),
    }
  } else {
    $keystone_public_bind_opts = {
      "${keystone_public_api_vip}:${ports[keystone_public_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[keystone_public_api_port]}" => $haproxy_listen_bind_param,
    }
    $keystone_admin_bind_opts = {
      "${keystone_admin_api_vip}:${ports[keystone_admin_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[keystone_admin_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $neutron_api_vip = hiera('neutron_api_vip', $controller_virtual_ip)
  if $neutron_bind_certificate {
    $neutron_bind_opts = {
      "${neutron_api_vip}:${ports[neutron_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[neutron_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $neutron_bind_certificate]),
    }
  } else {
    $neutron_bind_opts = {
      "${neutron_api_vip}:${ports[neutron_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[neutron_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $cinder_api_vip = hiera('cinder_api_vip', $controller_virtual_ip)
  if $cinder_bind_certificate {
    $cinder_bind_opts = {
      "${cinder_api_vip}:${ports[cinder_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[cinder_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $cinder_bind_certificate]),
    }
  } else {
    $cinder_bind_opts = {
      "${cinder_api_vip}:${ports[cinder_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[cinder_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $congress_api_vip = hiera('congress_api_vip', $controller_virtual_ip)
  if $congress_bind_certificate {
    $congress_bind_opts = {
      "${congress_api_vip}:${ports[congress_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[congress_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $congress_bind_certificate]),
    }
  } else {
    $congress_bind_opts = {
      "${congress_api_vip}:${ports[congress_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[congress_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $manila_api_vip = hiera('manila_api_vip', $controller_virtual_ip)
  if $manila_bind_certificate {
    $manila_bind_opts = {
      "${manila_api_vip}:${ports[manila_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[manila_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $manila_bind_certificate]),
    }
  } else {
    $manila_bind_opts = {
      "${manila_api_vip}:${ports[manila_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[manila_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $glance_api_vip = hiera('glance_api_vip', $controller_virtual_ip)
  if $glance_bind_certificate {
    $glance_bind_opts = {
      "${glance_api_vip}:${ports[glance_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[glance_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $glance_bind_certificate]),
    }
  } else {
    $glance_bind_opts = {
      "${glance_api_vip}:${ports[glance_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[glance_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $glance_registry_vip = hiera('glance_registry_vip', $controller_virtual_ip)
  $glance_registry_bind_opts = {
    "${glance_registry_vip}:${ports[glance_registry_port]}" => $haproxy_listen_bind_param,
  }

  $sahara_api_vip = hiera('sahara_api_vip', $controller_virtual_ip)
  if $sahara_bind_certificate {
    $sahara_bind_opts = {
      "${sahara_api_vip}:${ports[sahara_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[sahara_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $sahara_bind_certificate]),
    }
  } else {
    $sahara_bind_opts = {
      "${sahara_api_vip}:${ports[sahara_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[sahara_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $tacker_api_vip = hiera('tacker_api_vip', $controller_virtual_ip)
  if $tacker_bind_certificate {
    $tacker_bind_opts = {
      "${tacker_api_vip}:${ports[tacker_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[tacker_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $tacker_bind_certificate]),
    }
  } else {
    $tacker_bind_opts = {
      "${tacker_api_vip}:${ports[tacker_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[tacker_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $trove_api_vip = hiera('$trove_api_vip', $controller_virtual_ip)
  if $trove_bind_certificate {
    $trove_bind_opts = {
      "${trove_api_vip}:${ports[trove_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[trove_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $trove_bind_certificate]),
    }
  } else {
    $trove_bind_opts = {
      "${trove_api_vip}:${ports[trove_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[trove_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $nova_api_vip = hiera('nova_api_vip', $controller_virtual_ip)
  if $nova_bind_certificate {
    $nova_osapi_bind_opts = {
      "${nova_api_vip}:${ports[nova_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[nova_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $nova_bind_certificate]),
    }
    $nova_ec2_bind_opts = {
      "${nova_api_vip}:${ports[nova_ec2_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[nova_ec2_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $nova_bind_certificate]),
    }
    $nova_novnc_bind_opts = {
      "${nova_api_vip}:${ports[nova_novnc_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[nova_novnc_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $nova_bind_certificate]),
    }
  } else {
    $nova_osapi_bind_opts = {
      "${nova_api_vip}:${ports[nova_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[nova_api_port]}" => $haproxy_listen_bind_param,
    }
    $nova_ec2_bind_opts = {
      "${nova_api_vip}:${ports[nova_ec2_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[nova_ec2_port]}" => $haproxy_listen_bind_param,
    }
    $nova_novnc_bind_opts = {
      "${nova_api_vip}:${ports[nova_novnc_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[nova_novnc_port]}" => $haproxy_listen_bind_param,
    }
  }

  $nova_metadata_vip = hiera('nova_metadata_vip', $controller_virtual_ip)
  $nova_metadata_bind_opts = {
    "${nova_metadata_vip}:${ports[nova_metadata_port]}" => $haproxy_listen_bind_param,
  }

  $ceilometer_api_vip = hiera('ceilometer_api_vip', $controller_virtual_ip)
  if $ceilometer_bind_certificate {
    $ceilometer_bind_opts = {
      "${ceilometer_api_vip}:${ports[ceilometer_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[ceilometer_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $ceilometer_bind_certificate]),
    }
  } else {
    $ceilometer_bind_opts = {
      "${ceilometer_api_vip}:${ports[ceilometer_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[ceilometer_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $aodh_api_vip = hiera('aodh_api_vip', $controller_virtual_ip)
  if $aodh_bind_certificate {
    $aodh_bind_opts = {
      "${aodh_api_vip}:${ports[aodh_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[aodh_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $aodh_bind_certificate]),
    }
  } else {
    $aodh_bind_opts = {
      "${aodh_api_vip}:${ports[aodh_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[aodh_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $gnocchi_api_vip = hiera('gnocchi_api_vip', $controller_virtual_ip)
  if $gnocchi_bind_certificate {
    $gnocchi_bind_opts = {
      "${gnocchi_api_vip}:${ports[gnocchi_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[gnocchi_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $gnocchi_bind_certificate]),
    }
  } else {
    $gnocchi_bind_opts = {
      "${gnocchi_api_vip}:${ports[gnocchi_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[gnocchi_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  $swift_proxy_vip = hiera('swift_proxy_vip', $controller_virtual_ip)
  if $swift_bind_certificate {
    $swift_bind_opts = {
      "${swift_proxy_vip}:${ports[swift_proxy_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[swift_proxy_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $swift_bind_certificate]),
    }
  } else {
    $swift_bind_opts = {
      "${swift_proxy_vip}:${ports[swift_proxy_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[swift_proxy_port]}" => $haproxy_listen_bind_param,
    }
  }

  $heat_api_vip = hiera('heat_api_vip', $controller_virtual_ip)
  $heat_base_options = {
    'http-request' => [
      'set-header X-Forwarded-Proto https if { ssl_fc }',
      'set-header X-Forwarded-Proto http if !{ ssl_fc }']}
  if $heat_bind_certificate {
    $heat_bind_opts = {
      "${heat_api_vip}:${ports[heat_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[heat_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $heat_bind_certificate]),
    }
    $heat_ssl_options = {
      'rsprep' => "^Location:\\ http://${public_virtual_ip}(.*) Location:\\ https://${public_virtual_ip}\\1",
    }
    $heat_options = merge($heat_base_options, $heat_ssl_options)
    $heat_cw_bind_opts = {
      "${heat_api_vip}:${ports[heat_cw_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[heat_cw_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $heat_bind_certificate]),
    }
    $heat_cfn_bind_opts = {
      "${heat_api_vip}:${ports[heat_cfn_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[heat_cfn_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $heat_bind_certificate]),
    }
  } else {
    $heat_bind_opts = {
      "${heat_api_vip}:${ports[heat_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[heat_api_port]}" => $haproxy_listen_bind_param,
    }
    $heat_options = $heat_base_options
    $heat_cw_bind_opts = {
      "${heat_api_vip}:${ports[heat_cw_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[heat_cw_port]}" => $haproxy_listen_bind_param,
    }
    $heat_cfn_bind_opts = {
      "${heat_api_vip}:${ports[heat_cfn_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[heat_cfn_port]}" => $haproxy_listen_bind_param,
    }
  }

  $horizon_vip = hiera('horizon_vip', $controller_virtual_ip)
  if $horizon_bind_certificate {
    # NOTE(jaosorior): If the horizon_vip and the public_virtual_ip are the
    # same, the first option takes precedence. Which is the case when network
    # isolation is not enabled. This is not a problem as both options are
    # identical. If network isolation is enabled, this works correctly and
    # will add a TLS binding to both the horizon_vip and the
    # public_virtual_ip.
    # Even though for the public_virtual_ip the port 80 is listening, we
    # redirect to https in the horizon_options below.
    $horizon_bind_opts = {
      "${horizon_vip}:80"        => $haproxy_listen_bind_param,
      "${horizon_vip}:443"       => union($haproxy_listen_bind_param, ['ssl', 'crt', $horizon_bind_certificate]),
      "${public_virtual_ip}:80"  => $haproxy_listen_bind_param,
      "${public_virtual_ip}:443" => union($haproxy_listen_bind_param, ['ssl', 'crt', $horizon_bind_certificate]),
    }
    $horizon_options = {
      'cookie'   => 'SERVERID insert indirect nocache',
      'rsprep'   => '^Location:\ http://(.*) Location:\ https://\1',
      # NOTE(jaosorior): We always redirect to https for the public_virtual_ip.
      'redirect' => "scheme https code 301 if { hdr(host) -i ${public_virtual_ip} } !{ ssl_fc }",
    }
  } else {
    $horizon_bind_opts = {
      "${horizon_vip}:80" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:80" => $haproxy_listen_bind_param,
    }
    $horizon_options = {
      'cookie' => 'SERVERID insert indirect nocache',
    }
  }

  $ironic_api_vip = hiera('ironic_api_vip', $controller_virtual_ip)
  if $ironic_bind_certificate {
    $ironic_bind_opts = {
      "${ironic_api_vip}:${ports[ironic_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[ironic_api_ssl_port]}" => union($haproxy_listen_bind_param, ['ssl', 'crt', $ironic_bind_certificate]),
    }
  } else {
    $ironic_bind_opts = {
      "${ironic_api_vip}:${ports[ironic_api_port]}" => $haproxy_listen_bind_param,
      "${public_virtual_ip}:${ports[ironic_api_port]}" => $haproxy_listen_bind_param,
    }
  }

  if $haproxy_stats_bind_certificate {
    $haproxy_stats_bind_opts = {
      "${controller_virtual_ip}:1993" => union($haproxy_listen_bind_param, ['ssl', 'crt', $haproxy_stats_bind_certificate]),
    }
  } else {
    $haproxy_stats_bind_opts = {
      "${controller_virtual_ip}:1993" => $haproxy_listen_bind_param,
    }
  }

  $mysql_vip = hiera('mysql_vip', $controller_virtual_ip)
  $mysql_bind_opts = {
    "${mysql_vip}:3306" => $haproxy_listen_bind_param,
  }

  $rabbitmq_vip = hiera('rabbitmq_vip', $controller_virtual_ip)
  $rabbitmq_bind_opts = {
    "${rabbitmq_vip}:5672" => $haproxy_listen_bind_param,
  }

  $redis_vip = hiera('redis_vip', $controller_virtual_ip)
  $redis_bind_opts = {
    "${redis_vip}:6379" => $haproxy_listen_bind_param,
  }

  sysctl::value { 'net.ipv4.ip_nonlocal_bind': value => '1' }

  class { '::haproxy':
    service_manage   => $haproxy_service_manage,
    global_options   => {
      'log'                      => "${haproxy_log_address} local0",
      'pidfile'                  => '/var/run/haproxy.pid',
      'user'                     => 'haproxy',
      'group'                    => 'haproxy',
      'daemon'                   => '',
      'maxconn'                  => $haproxy_global_maxconn,
      'ssl-default-bind-ciphers' => $ssl_cipher_suite,
      'ssl-default-bind-options' => $ssl_options,
    },
    defaults_options => {
      'mode'    => 'tcp',
      'log'     => 'global',
      'retries' => '3',
      'timeout' => $haproxy_default_timeout,
      'maxconn' => $haproxy_default_maxconn,
    },
  }

  Haproxy::Listen {
    options => {
      'option' => [],
    }
  }

  $stats_base = ['enable', 'uri /']
  if $haproxy_stats_password {
    $stats_config = union($stats_base, ["auth ${haproxy_stats_user}:${haproxy_stats_password}"])
  } else {
    $stats_config = $stats_base
  }
  haproxy::listen { 'haproxy.stats':
    bind             => $haproxy_stats_bind_opts,
    mode             => 'http',
    options          => {
      'stats' => $stats_config,
    },
    collect_exported => false,
  }

  if $keystone_admin {
    haproxy::listen { 'keystone_admin':
      bind             => $keystone_admin_bind_opts,
      collect_exported => false,
      mode             => 'http', # Needed for http-request option
      options          => {
          'http-request' => [
            'set-header X-Forwarded-Proto https if { ssl_fc }',
            'set-header X-Forwarded-Proto http if !{ ssl_fc }'],
      },
    }
    haproxy::balancermember { 'keystone_admin':
      listening_service => 'keystone_admin',
      ports             => '35357',
      ipaddresses       => hiera('keystone_admin_api_node_ips',$controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $keystone_public {
    haproxy::listen { 'keystone_public':
      bind             => $keystone_public_bind_opts,
      collect_exported => false,
      mode             => 'http', # Needed for http-request option
      options          => {
          'http-request' => [
            'set-header X-Forwarded-Proto https if { ssl_fc }',
            'set-header X-Forwarded-Proto http if !{ ssl_fc }'],
      },
    }
    haproxy::balancermember { 'keystone_public':
      listening_service => 'keystone_public',
      ports             => '5000',
      ipaddresses       => hiera('keystone_public_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $neutron {
    haproxy::listen { 'neutron':
      bind             => $neutron_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'neutron':
      listening_service => 'neutron',
      ports             => '9696',
      ipaddresses       => hiera('neutron_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $cinder {
    haproxy::listen { 'cinder':
      bind             => $cinder_bind_opts,
      collect_exported => false,
      mode             => 'http', # Needed for http-request option
      options          => {
          'http-request' => [
            'set-header X-Forwarded-Proto https if { ssl_fc }',
            'set-header X-Forwarded-Proto http if !{ ssl_fc }'],
      },
    }
    haproxy::balancermember { 'cinder':
      listening_service => 'cinder',
      ports             => '8776',
      ipaddresses       => hiera('cinder_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $manila {
    haproxy::listen { 'manila':
      bind             => $manila_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'manila':
      listening_service => 'manila',
      ports             => '8786',
      ipaddresses       => hiera('manila_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $sahara {
    haproxy::listen { 'sahara':
      bind             => $sahara_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'sahara':
      listening_service => 'sahara',
      ports             => '8386',
      ipaddresses       => hiera('sahara_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $trove {
    haproxy::listen { 'trove':
      bind             => $trove_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'trove':
      listening_service => 'trove',
      ports             => '8779',
      ipaddresses       => hiera('trove_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $glance_api {
    haproxy::listen { 'glance_api':
      bind             => $glance_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'glance_api':
      listening_service => 'glance_api',
      ports             => '9292',
      ipaddresses       => hiera('glance_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $glance_registry {
    haproxy::listen { 'glance_registry':
      bind             => $glance_registry_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'glance_registry':
      listening_service => 'glance_registry',
      ports             => '9191',
      ipaddresses       => hiera('glance_registry_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $nova_ec2 {
    haproxy::listen { 'nova_ec2':
      bind             => $nova_ec2_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'nova_ec2':
      listening_service => 'nova_ec2',
      ports             => '8773',
      ipaddresses       => hiera('nova_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $nova_osapi {
    haproxy::listen { 'nova_osapi':
      bind             => $nova_osapi_bind_opts,
      collect_exported => false,
      mode             => 'http',
      options          => {
          'http-request' => [
            'set-header X-Forwarded-Proto https if { ssl_fc }',
            'set-header X-Forwarded-Proto http if !{ ssl_fc }'],
      },
    }
    haproxy::balancermember { 'nova_osapi':
      listening_service => 'nova_osapi',
      ports             => '8774',
      ipaddresses       => hiera('nova_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $nova_metadata {
    haproxy::listen { 'nova_metadata':
      bind             => $nova_metadata_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'nova_metadata':
      listening_service => 'nova_metadata',
      ports             => '8775',
      ipaddresses       => hiera('nova_metadata_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $nova_novncproxy {
    haproxy::listen { 'nova_novncproxy':
      bind             => $nova_novnc_bind_opts,
      options          => {
        'balance' => 'source',
        'timeout' => [ 'tunnel 1h' ],
      },
      collect_exported => false,
    }
    haproxy::balancermember { 'nova_novncproxy':
      listening_service => 'nova_novncproxy',
      ports             => '6080',
      ipaddresses       => hiera('nova_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $ceilometer {
    haproxy::listen { 'ceilometer':
      bind             => $ceilometer_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'ceilometer':
      listening_service => 'ceilometer',
      ports             => '8777',
      ipaddresses       => hiera('ceilometer_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $aodh {
    haproxy::listen { 'aodh':
      bind             => $aodh_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'aodh':
      listening_service => 'aodh',
      ports             => '8042',
      ipaddresses       => hiera('aodh_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $gnocchi {
    haproxy::listen { 'gnocchi':
      bind             => $gnocchi_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'gnocchi':
      listening_service => 'gnocchi',
      ports             => '8041',
      ipaddresses       => hiera('gnocchi_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => ['check', 'inter 2000', 'rise 2', 'fall 5'],
    }
  }

  if $swift_proxy_server {
    haproxy::listen { 'swift_proxy_server':
      bind             => $swift_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'swift_proxy_server':
      listening_service => 'swift_proxy_server',
      ports             => '8080',
      ipaddresses       => hiera('swift_proxy_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $heat_api {
    haproxy::listen { 'heat_api':
      bind             => $heat_bind_opts,
      options          => $heat_options,
      collect_exported => false,
      mode             => 'http',
    }
    haproxy::balancermember { 'heat_api':
      listening_service => 'heat_api',
      ports             => '8004',
      ipaddresses       => hiera('heat_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $heat_cloudwatch {
    haproxy::listen { 'heat_cloudwatch':
      bind             => $heat_cw_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'heat_cloudwatch':
      listening_service => 'heat_cloudwatch',
      ports             => '8003',
      ipaddresses       => hiera('heat_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $heat_cfn {
    haproxy::listen { 'heat_cfn':
      bind             => $heat_cfn_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'heat_cfn':
      listening_service => 'heat_cfn',
      ports             => '8000',
      ipaddresses       => hiera('heat_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $horizon {
    haproxy::listen { 'horizon':
      bind             => $horizon_bind_opts,
      options          => $horizon_options,
      mode             => 'http',
      collect_exported => false,
    }
    haproxy::balancermember { 'horizon':
      listening_service => 'horizon',
      ports             => '80',
      ipaddresses       => hiera('horizon_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => union($haproxy_member_options, ["cookie ${::hostname}"]),
    }
  }

  if $mysql_clustercheck {
    $mysql_listen_options = {
      'option'         => [ 'tcpka', 'httpchk' ],
      'timeout client' => '90m',
      'timeout server' => '90m',
      'stick-table'    => 'type ip size 1000',
      'stick'          => 'on dst',
    }
    $mysql_member_options = union($haproxy_member_options, ['backup', 'port 9200', 'on-marked-down shutdown-sessions'])
  } else {
    $mysql_listen_options = {
      'timeout client' => '90m',
      'timeout server' => '90m',
    }
    $mysql_member_options = union($haproxy_member_options, ['backup'])
  }

  if $ironic {
    haproxy::listen { 'ironic':
      bind             => $ironic_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'ironic':
      listening_service => 'ironic',
      ports             => '6385',
      ipaddresses       => hiera('ironic_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $mysql {
    haproxy::listen { 'mysql':
      bind             => $mysql_bind_opts,
      options          => $mysql_listen_options,
      collect_exported => false,
    }
    haproxy::balancermember { 'mysql-backup':
      listening_service => 'mysql',
      ports             => '3306',
      ipaddresses       => hiera('mysql_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $mysql_member_options,
    }
  }

  if $rabbitmq {
    haproxy::listen { 'rabbitmq':
      bind             => $rabbitmq_bind_opts,
      options          => {
        'option'  => [ 'tcpka' ],
        'timeout' => [ 'client 0', 'server 0' ],
      },
      collect_exported => false,
    }
    haproxy::balancermember { 'rabbitmq':
      listening_service => 'rabbitmq',
      ports             => '5672',
      ipaddresses       => hiera('rabbitmq_network', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $redis {
    if $redis_password {
      $redis_tcp_check_options = ["send AUTH\\ ${redis_password}\\r\\n"]
    } else {
      $redis_tcp_check_options = []
    }
    haproxy::listen { 'redis':
      bind             => $redis_bind_opts,
      options          => {
        'balance'   => 'first',
        'option'    => ['tcp-check',],
        'tcp-check' => union($redis_tcp_check_options, ['send PING\r\n','expect string +PONG','send info\ replication\r\n','expect string role:master','send QUIT\r\n','expect string +OK']),
      },
      collect_exported => false,
    }
    haproxy::balancermember { 'redis':
      listening_service => 'redis',
      ports             => '6379',
      ipaddresses       => hiera('redis_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  $midonet_api_vip = hiera('midonet_api_vip', $controller_virtual_ip)
  $midonet_bind_opts = {
    "${midonet_api_vip}:8081" => [],
    "${public_virtual_ip}:8081" => [],
  }

  if $midonet_api {
    haproxy::listen { 'midonet_api':
      bind             => $midonet_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'midonet_api':
      listening_service => 'midonet_api',
      ports             => '8081',
      ipaddresses       => hiera('midonet_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  $opendaylight_api_vip = hiera('opendaylight_api_vip', $controller_virtual_ip)
  $opendaylight_bind_opts = {
    "${opendaylight_api_vip}:8081" => [],
    "${public_virtual_ip}:8081" => [],
  }

  if $opendaylight {
    haproxy::listen { 'opendaylight':
      bind             => $opendaylight_bind_opts,
      options          => {
        'balance'   => 'source',
      },
      collect_exported => false,
    }
    haproxy::balancermember { 'opendaylight':
      listening_service => 'opendaylight',
      ports             => '8081',
      ipaddresses       => hiera('opendaylight_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => ['check', 'inter 2000', 'rise 2', 'fall 5'],
    }
  }

  if $congress {
    haproxy::listen { 'congress':
      bind             => $congress_bind_opts,
      collect_exported => false,
    }

    haproxy::balancermember { 'congress':
      listening_service => 'congress',
      ports             => '1789',
      ipaddresses       => hiera('congress_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }

  if $tacker {
    haproxy::listen { 'tacker':
      bind             => $tacker_bind_opts,
      collect_exported => false,
    }
    haproxy::balancermember { 'tacker':
      listening_service => 'tacker',
      ports             => '8888',
      ipaddresses       => hiera('tacker_api_node_ips', $controller_hosts_real),
      server_names      => $controller_hosts_names_real,
      options           => $haproxy_member_options,
    }
  }
}
