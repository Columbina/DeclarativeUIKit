import SwiftUI

@available(iOS 13.0, *)
public struct DeclarativeViewControllerPreview: View {
    private let configuration: PreviewConfiguration
    private let viewController: UIViewController

    public var body: some View {
        ManagedPreview(configuration: configuration) {
            ViewControllerPreviewContainer {
                viewController
            }
        }
    }

    public init(configuration: PreviewConfiguration,
                _ viewController: () -> UIViewController) {
        self.configuration = configuration
        self.viewController = viewController()
    }
}


@available(iOS 13.0, *)
struct ManagedPreview<Preview: View>: View {
    private let configuration: PreviewConfiguration
    private let preview: Preview

    var body: some View {
        Group {
            ForEach(configuration.devices, id: \.self) {
                preview
                    .previewDevice($0)
            }
        }
    }

    init(configuration: PreviewConfiguration,
         @ViewBuilder builder: @escaping () -> Preview) {
        self.configuration = configuration
        preview = builder()
    }
}


@available(iOS 13.0, *)
struct ViewControllerPreviewContainer: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> UIViewController

    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        viewControllerBuilder()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

@available(iOS 13.0, *)
public struct PreviewConfiguration {
    let devices: [PreviewDevice]

    public init(devices: [PreviewDevice]) {
        self.devices = devices
    }
}
