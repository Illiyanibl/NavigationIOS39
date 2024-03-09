//
//  MapView.swift
//  BlinoviOS-39_Navigation_0
//override func viewDidLoad() {
//  Created by Illya Blinov on 6.03.24.
//
import MapKit

final class MapView: UIViewController {

    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.mapType = .standard
        view.delegate = self
        return view
    }()

    lazy var goButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white.withAlphaComponent(0.7)
        button.layer.cornerRadius = 12
        button.addTarget(nil, action: #selector(go), for: .touchUpInside)
        return button
    }()

    lazy var locationManager = CLLocationManager()
    var points = [MKAnnotation]()
    var userCoordinate: CLLocationCoordinate2D?
    var overlays = [MKPolyline]()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        //locationManager.startUpdatingLocation() не потребовалось
        mapView.showsUserLocation = true
        if #available(iOS 17.0, *) {
            mapView.showsUserTrackingButton = true
        } else {}
        setupView()
    }

    private func setupView(){
        view.addSubviews([mapView, goButton])
        setupConstraints(safeArea: view.safeAreaLayoutGuide)
        requestLocation()
        goUserLocation()
        setupGesture()
    }

    private func requestLocation(){
        locationManager.requestWhenInUseAuthorization()
    }

    private func goUserLocation(){
        userCoordinate = locationManager.location?.coordinate
        guard let userCoordinate else { return }
        let region = MKCoordinateRegion(center: userCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    private func goDestination(){
        guard let destinationCoordinate = points.first?.coordinate  else { return }
        let region = MKCoordinateRegion(center: destinationCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    private func setPoint(location: CLLocationCoordinate2D) {
        let annotaion = MKPointAnnotation()
        userCoordinate = locationManager.location?.coordinate
        annotaion.title = "Destination"
        let anotaionCoordinate = location
        annotaion.coordinate = anotaionCoordinate
        if points.isEmpty {
            points.append(annotaion)
        } else {
            mapView.removeAnnotations(points)
            mapView.removeOverlays(overlays)
            points.removeAll()
            overlays.removeAll()
            points.append(annotaion)
        }
        guard let newPoint = points.first else { return}

        mapView.addAnnotation(newPoint)
        goDestination()
    }

    @objc private func go(){
        guard let userCoordinate else { return }
        guard let destinationCoordinate = points.first?.coordinate  else { return }
        mapView.removeOverlays(overlays)
        overlays.removeAll()

        let requestRoute = MKDirections.Request()
        requestRoute.source = MKMapItem(placemark: MKPlacemark(coordinate: userCoordinate))
        requestRoute.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        let direction = MKDirections(request: requestRoute)

        direction.calculate(){ [weak self] result, error in
            guard let self else { return }
            guard let rout = result?.routes.first else { return }
            overlays.append(rout.polyline)
            guard let overlay = overlays.first else { return }
            self.mapView.addOverlay(overlay)
            self.mapView.setVisibleMapRect(overlay.boundingMapRect, animated: true)
        }
    }

    private func setupGesture(){
        let tapMapView = UITapGestureRecognizer(target: self, action: #selector(tapMap))
        mapView.addGestureRecognizer(tapMapView)
    }

    @objc func tapMap(sender: UITapGestureRecognizer){   // or UILongPressGestureRecognizer
        let point = sender.location(in: mapView)
        let location = mapView.convert(point, toCoordinateFrom: mapView)
        setPoint(location: location)
    }

    private func setupConstraints(safeArea: UILayoutGuide){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),

            goButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -6),
            goButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -6),
            goButton.heightAnchor.constraint(equalToConstant: 40),
            goButton.widthAnchor.constraint(equalToConstant: 40),

        ])
    }
}

extension MapView : CLLocationManagerDelegate {} //не потребовалось
extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        go()
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .orange
            renderer.lineWidth = 6
            return renderer
        }
        return MKOverlayRenderer()
    }

}
